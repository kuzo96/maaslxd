### Automated GOLE LibreNMS

Configuration of LibreNMS instance in librenms namespace on NRP for the Automate GOLE.

**The chart is automagically deployed to Nautilus librenms namespace on every push to master!**

To upgrade manually:

```shell
helm dependency update librenms
helm upgrade -n librenms librenms librenms
```

Meeting notes:<br>
https://docs.google.com/document/d/12R9m6-JchmF9c3tb4qKBuEyZArpeIrcRToOPxkHpyDc/edit?usp=sharing

Cloned from: https://github.com/midokura/helm-charts-community
