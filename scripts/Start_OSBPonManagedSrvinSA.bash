#!/bin/bash
# Start OS Build Plan on Already Managed Server.
# Preenesh Nayanasudhan

echo "OS Build Plan Id is $1"
echo "Target Server Id is $2"

cd /opsw/api/com/opsware/osprov/OSBuildPlanService/method
job_id=`./.startOSBuildPlan:i self:i="com.opsware.osprov.OSBuildPlanRef:$1" server:i="com.opsware.server.ServerRef:$2"`
cmnd_exit_status=$?
if [ $cmnd_exit_status -eq 0 ]
then
	echo "The command was successful."
	echo $job_id
else
	echo "The command failed"
	echo "Exit status = " $cmnd_exit_status
fi