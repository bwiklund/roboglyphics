(function() {
  var Pen, Roboglypics, Vec, _raf,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  _raf = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame;

  Vec = (function() {

    function Vec(x, y) {
      this.x = x != null ? x : 0;
      this.y = y != null ? y : 0;
    }

    Vec.prototype.add = function(o) {
      this.x += o.x;
      return this.y += o.y;
    };

    return Vec;

  })();

  Pen = (function() {

    function Pen(canvas) {
      this.canvas = canvas;
      this.initDefaults();
      if (typeof this.onSetup === "function") {
        this.onSetup();
      }
      this.resetPoint();
    }

    Pen.prototype.randAngle = function() {
      return Math.random() * Math.PI * 2;
    };

    Pen.prototype.rand = function() {
      return (Math.random() - 0.5) * 2;
    };

    Pen.prototype.initDefaults = function() {
      this.scale = 1;
      this.age = 0;
      this.angle = 0;
      this.dAngle = 0;
      this.ddAngle = 0;
      this.dampDAngle = 1;
      this.dampDDAngle = 1;
      this.changeDirectionChance = 0;
      this.maxLength = Number.POSITIVE_INFINITY;
      this.weight = 2;
      this.margin = Math.min(100, 0.1 * this.canvas.width);
      this.lineHeight = 30;
      this.letterSpacing = 10;
      this.baseX = Number.POSITIVE_INFINITY;
      return this.baseY = this.margin - this.lineHeight;
    };

    Pen.prototype.angleFilter = function() {
      return this.angle;
    };

    Pen.prototype.resetPoint = function() {
      this.age = 0;
      this.pos = new Vec(this.baseX, this.baseY);
      this.newLineIfNeeded();
      return this.changeDirection();
    };

    Pen.prototype.newLineIfNeeded = function() {
      this.baseX += this.letterSpacing * this.scale;
      if (this.baseX > this.canvas.width - this.margin) {
        this.baseX = this.margin;
        this.baseY += this.lineHeight * this.scale;
      }
      if (this.baseY > this.canvas.height - this.margin) {
        return this.done = true;
      }
    };

    Pen.prototype.changeDirection = function() {
      this.angle = this.randAngle();
      this.dAngle = 0.005 * this.rand();
      this.ddAngle = 0.0005 * this.rand();
      this.changeDirectionChance = 0.001;
      this.dampDAngle = 1;
      this.dampDDAngle = 1;
      return this.maxLength = 200 + Math.random() * 100;
    };

    Pen.prototype.step = function() {
      if (typeof this.onStep === "function") {
        this.onStep();
      }
      if (this.age > this.maxLength) {
        this.resetPoint();
      }
      if (this.pos.x < 0 || this.pos.y < 0 || this.pos.x > this.canvas.width || this.pos.y > this.canvas.height) {
        this.resetPoint();
      }
      this.age++;
      this.pos.x += this.scale * 0.1 * Math.cos(this.angleFilter());
      this.pos.y += this.scale * 0.1 * Math.sin(this.angleFilter());
      this.dAngle += this.ddAngle;
      this.angle += this.dAngle;
      this.dAngle *= this.dampDAngle;
      this.ddAngle *= this.dampDDAngle;
      if (Math.random() < this.changeDirectionChance) {
        return this.changeDirection();
      }
    };

    Pen.prototype.draw = function(a) {
      a.save();
      a.translate(this.pos.x, this.pos.y);
      a.beginPath();
      a.arc(0, 0, 3, this.weight * this.scale, 0, Math.PI * 2, true);
      a.fill();
      return a.restore();
    };

    return Pen;

  })();

  Roboglypics = (function() {

    function Roboglypics(canvasEl, settings) {
      this.canvasEl = canvasEl;
      this.settings = settings;
      this.onRender = __bind(this.onRender, this);

      this.pen = null;
      this.a = canvasEl.getContext('2d');
      this.canvasEl.width = this.canvasEl.offsetWidth;
      this.canvasEl.height = this.canvasEl.offsetHeight;
      _raf(this.onRender);
    }

    Roboglypics.prototype.reset = function() {
      return this.a.clearRect(0, 0, this.canvasEl.width, this.canvasEl.height);
    };

    Roboglypics.prototype.setPen = function(penCtor) {
      return this.pen = new penCtor(this.canvasEl);
    };

    Roboglypics.prototype.onRender = function() {
      var i, _i, _ref;
      this.a.fillStyle = 'black';
      if (this.pen != null) {
        for (i = _i = 0, _ref = this.settings.speed; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          this.pen.step();
          if (this.pen.done) {
            break;
          }
          this.pen.draw(this.a);
        }
      }
      return _raf(this.onRender);
    };

    return Roboglypics;

  })();

  window.rg = {
    Roboglypics: Roboglypics,
    Pen: Pen,
    Vec: Vec
  };

}).call(this);
