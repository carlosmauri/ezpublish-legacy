<?php
/**
 * File containing the eZWorkflowEventType class.
 *
 * @copyright Copyright (C) eZ Systems AS. All rights reserved.
 * @license For full copyright and license information view LICENSE file distributed with this source code.
 * @version //autogentag//
 * @package kernel
 */

//!! eZKernel
//! The class eZWorkflowEventType does
/*!

*/

class eZWorkflowEventType extends eZWorkflowType
{
    /**
     * Constructor
     *
     * @param string $typeString
     * @param string $name
     */
    public function __construct( $typeString, $name )
    {
        parent::__construct( "event", $typeString, ezpI18n::tr( 'kernel/workflow/event', "Event" ), $name );
    }

    /**
     * @deprecated
     * @param string $typeString
     * @param string $name
     */
    public function eZWorkflowEventType( $typeString, $name )
    {
        self::__construct( $typeString, $name );
    }

    static function registerEventType( $typeString, $class_name )
    {
        eZWorkflowType::registerType( "event", $typeString, $class_name );
    }
}

?>
