(function() {
  var BassClef, Clef, Fantasy, Giraffes, Leonardo, Loopy, MODE, Madman, Roboglyph, Stacatto, modes,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  modes = [];

  MODE = function(klass) {
    return modes.push(klass);
  };

  MODE(Clef = (function(_super) {

    __extends(Clef, _super);

    function Clef() {
      return Clef.__super__.constructor.apply(this, arguments);
    }

    Clef.prototype.onSetup = function() {
      return this.scale = 2;
    };

    Clef.prototype.angleFilter = function() {
      return Math.PI * 2 * Math.sin(this.angle * 100);
    };

    Clef.prototype.onStep = function() {
      return this.weight = this.age / this.maxLength;
    };

    Clef.prototype.changeDirection = function() {
      this.angle = this.randAngle();
      this.dAngle = 0.0005 * this.rand();
      this.ddAngle = 0;
      this.changeDirectionChance = 0.001;
      this.dampDAngle = 1;
      this.dampDDAngle = 1;
      return this.maxLength = 500 + Math.random() * 600;
    };

    return Clef;

  })(window.rg.Pen));

  MODE(Roboglyph = (function(_super) {

    __extends(Roboglyph, _super);

    function Roboglyph() {
      return Roboglyph.__super__.constructor.apply(this, arguments);
    }

    Roboglyph.prototype.angleFilter = function() {
      var mult;
      mult = Math.PI / 3;
      return Math.round(this.angle / mult) * mult;
    };

    return Roboglyph;

  })(window.rg.Pen));

  MODE(Loopy = (function(_super) {

    __extends(Loopy, _super);

    function Loopy() {
      return Loopy.__super__.constructor.apply(this, arguments);
    }

    Loopy.prototype.changeDirection = function() {
      this.angle = this.randAngle();
      this.dAngle = 0.005 * this.rand();
      this.ddAngle = 0.0005 * this.rand();
      this.changeDirectionChance = 0.001;
      this.dampDAngle = 1;
      this.dampDDAngle = 1;
      return this.maxLength = 200 + Math.random() * 100;
    };

    return Loopy;

  })(window.rg.Pen));

  MODE(Giraffes = (function(_super) {

    __extends(Giraffes, _super);

    function Giraffes() {
      return Giraffes.__super__.constructor.apply(this, arguments);
    }

    Giraffes.prototype.changeDirection = function() {
      this.angle = -Math.PI / 2;
      this.dAngle = 0.005 * this.rand();
      this.ddAngle = 0.0005 * this.rand();
      this.changeDirectionChance = 0.005;
      this.dampDAngle = 1;
      this.dampDDAngle = 1;
      return this.maxLength = 200 + Math.random() * 100;
    };

    return Giraffes;

  })(window.rg.Pen));

  MODE(Leonardo = (function(_super) {

    __extends(Leonardo, _super);

    function Leonardo() {
      return Leonardo.__super__.constructor.apply(this, arguments);
    }

    Leonardo.prototype.changeDirection = function() {
      this.angle = this.randAngle();
      this.dAngle = 0.02 * this.rand() * 0.5;
      this.ddAngle = 0.01 * this.rand() * 0.5;
      this.changeDirectionChance = 0.008;
      this.dampDAngle = 0.99;
      this.dampDDAngle = 0.99;
      return this.maxLength = 200 + Math.random() * 600;
    };

    return Leonardo;

  })(window.rg.Pen));

  MODE(Fantasy = (function(_super) {

    __extends(Fantasy, _super);

    function Fantasy() {
      return Fantasy.__super__.constructor.apply(this, arguments);
    }

    Fantasy.prototype.changeDirection = function() {
      this.angle = this.randAngle();
      this.dAngle = 0.005 + 0.06 * Math.random();
      this.ddAngle = 0;
      this.changeDirectionChance = 0;
      this.dampDAngle = 1;
      this.dampDDAngle = 1;
      return this.maxLength = 200 + Math.random() * 600;
    };

    return Fantasy;

  })(window.rg.Pen));

  MODE(BassClef = (function(_super) {

    __extends(BassClef, _super);

    function BassClef() {
      return BassClef.__super__.constructor.apply(this, arguments);
    }

    BassClef.prototype.onSetup = function() {
      return this.scale = 2;
    };

    BassClef.prototype.angleFilter = function() {
      return Math.PI * 2 * Math.sin(this.angle * 100);
    };

    BassClef.prototype.onStep = function() {
      return this.weight = 2 * (1 - this.age / this.maxLength);
    };

    BassClef.prototype.changeDirection = function() {
      this.angle = this.randAngle();
      this.dAngle = 0.0005 * this.rand();
      this.ddAngle = 0;
      this.changeDirectionChance = 0.001;
      this.dampDAngle = 1;
      this.dampDDAngle = 1;
      return this.maxLength = 500 + Math.random() * 600;
    };

    return BassClef;

  })(window.rg.Pen));

  MODE(Stacatto = (function(_super) {

    __extends(Stacatto, _super);

    function Stacatto() {
      return Stacatto.__super__.constructor.apply(this, arguments);
    }

    Stacatto.prototype.onSetup = function() {
      return this.scale = 2.5;
    };

    Stacatto.prototype.angleFilter = function() {
      return Math.PI * 2 * Math.sin(this.angle * 100);
    };

    Stacatto.prototype.onStep = function() {
      this.weight = 2 * (1 - this.age / this.maxLength);
      if (this.age % 200 < 100) {
        return this.weight = 0.5;
      }
    };

    Stacatto.prototype.changeDirection = function() {
      this.angle = this.randAngle();
      this.dAngle = 0.0005 * this.rand();
      this.ddAngle = 0;
      this.changeDirectionChance = 0.001;
      this.dampDAngle = 1;
      this.dampDDAngle = 1;
      return this.maxLength = 500 + Math.random() * 600;
    };

    return Stacatto;

  })(window.rg.Pen));

  MODE(Madman = (function(_super) {

    __extends(Madman, _super);

    function Madman() {
      return Madman.__super__.constructor.apply(this, arguments);
    }

    Madman.prototype.angleFilter = function() {
      if (this.age % 70 < 60) {
        return Math.PI * 2 * Math.cos(this.angle);
      } else {
        return this.rand() * Math.PI;
      }
    };

    Madman.prototype.changeDirection = function() {
      this.weight = Math.random();
      this.angle = this.randAngle();
      this.dAngle = 0.005 * this.rand();
      this.ddAngle = 0.001 * this.rand();
      this.changeDirectionChance = 0.1;
      this.dampDAngle = 0.9;
      this.dampDDAngle = 0.9;
      return this.maxLength = 500 + Math.random() * 600;
    };

    return Madman;

  })(window.rg.Pen));

  window.rgSamples = modes;

}).call(this);
