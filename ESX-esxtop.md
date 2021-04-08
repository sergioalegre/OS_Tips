Umbrales de los valores: http://www.yellow-bricks.com/esxtop/

High %RDY (>10) values can be an indication that the host is under physical CPU contention due to the demands of the virtual machines or that a virtual machine(s) has been overprovisioned/allocated too many vCPUs. Ideally you want to see the ready time to be under 10% but best if closer to 5%.

If  %USED is relatively low, but %RDY times are high it is a good indication that the virtual machine is over-provisioned. Where possible a single vCPU should be used.
