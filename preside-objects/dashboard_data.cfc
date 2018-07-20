/**
 * @nolabel   true
 * @versioned false
 * @datamanagerEnabled false
 */
component output=false {
	property name="rule" relationship="many-to-one" relatedto="dashboard_rules"  required=true;
	property name="hits" type="numeric" dbtype="int" required=true default=0 ;
}
