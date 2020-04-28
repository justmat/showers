
Engine_Showers : CroneEngine {

  var <synth;

  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }

  alloc {
    SynthDef(\Showers, {
      arg out, rain = 1.0, thunder = 0.7;
      var noise1, noise2, verb1, verb2, sig;

      noise1 = PinkNoise.ar(0.08 + LFNoise1.kr(0.3, 0.02)) + LPF.ar(Dust2.ar(LFNoise1.kr(0.2).range(40, 50)), 7000);
      noise1 = HPF.ar(noise1, 400);

      verb1 = tanh(3 * GVerb.ar(noise1, 250, 100, 0.25, drylevel: 0.3)) * Line.kr(0, rain, 10);

      noise2 = PinkNoise.ar(LFNoise1.kr(3).clip(0, 1) * LFNoise1.kr(2).clip(0, 1) ** 1.8);
      noise2 = LPF.ar( 10 * HPF.ar(noise2, 20), LFNoise1.kr(1).exprange(100, 2500)).tanh;

      verb2 = GVerb.ar(noise2, 270, 30, 0.7, drylevel: 0.5) * Line.kr(0, thunder, 30);
      
      sig = Mix.new([verb1, verb2]);
      sig = Limiter.ar(sig);

      Out.ar(out, sig);
      }).add;

      context.server.sync;

      synth = Synth.new(\Showers, [
        \out, context.out_b.index],
        context.xg);

      this.addCommand("rain", "f", {|msg|
      synth.set(\rain, msg[1]);
    });

      this.addCommand("thunder", "f", {|msg|
      synth.set(\thunder, msg[1]);
    });

  }
  // define a function that is called when the synth is shut down
  free {
    synth.free;
  }
}