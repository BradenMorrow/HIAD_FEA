cant_beam_driver drives the analysis of a cylindrical, cantelever beam.  This is best used to test the functionality of the Newton-Rapson solver and displacement solver.
In the Newton-Rapson solver, a load is placed on the end of the beam and the reaction is calculated.  In displacement solver, a total displacement increment is specified
and the reaction for each step is calculated.

beam_enf_disp_driver drives the analysis of a rectangular beam with a spring attached at the end.  This driver is best used to test the functionality of the enforce
displacement solver.  The end of the spring is offset and the reaction on the beam is then calculated in increments.  All the degrees of freedom of the last node must
be set to 1 (bounded).

