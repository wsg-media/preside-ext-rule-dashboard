/**
 *
 * @nolabel
 */
component extends="preside.system.base.SystemPresideObject" {
	property name="user"   relationship="many-to-one" relatedTo="security_user"         ;
	property name="instanceid" type="string" dbtype="varchar" maxLength="20" required=true  ;
	property name="widgetid"  type="string" dbtype="varchar" maxLength="20" required=true;
	property name="ordinalOrder"  type="numeric" ;

}
