/**
 * @versioned false
 * @datamanagerEnabled true
 */

component output=false datamanagerGridFields="label,enabled,last_ran,next_run"{
	property name="condition" relationship="many-to-one" relatedto="rules_engine_condition"  required=false control="conditionPicker";
	property name="crontab_definition"   type="string"  dbtype="varchar" maxlength=100 required=false;
	property name="enabled"              type="boolean" dbtype="boolean"               requried=false default=false;
	property name="last_ran"             type="date"    dbtype="datetime"              required=false;
	property name="next_run"             type="date"    dbtype="datetime"              required=false;

}
