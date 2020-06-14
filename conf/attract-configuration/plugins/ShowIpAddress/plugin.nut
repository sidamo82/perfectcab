///////////////////////////////////////////////////
//
// Attract-Mode Frontend - Show IP Address
//
///////////////////////////////////////////////////
//
// Define use configurable settings
//
class UserConfig </ help="Show ip dddress information" /> {
	</ label="Control", help="The button to press to view ip address", is_input=true, order=1 />
	button="H";
}

//
// Load file utilities
//
local my_dir = fe.script_dir;
dofile( my_dir + "file_util.nut" );

fe.load_module( "submenu" );
local config=fe.get_config();

//
// Define our history viewer by extending the SubMenu class from the
// "submenu" module
//
class ShowIpAddress extends SubMenu
{
	m_text = "";

	constructor()
	{
		base.constructor( config["button"] );

		m_text = fe.add_text( "", 0, 0, fe.layout.width, fe.layout.height );
		m_text.first_line_hint = 1; // enables word wrapping
		m_text.charsize = fe.layout.height / 40;
		m_text.bg_alpha=220;
		m_text.visible=false;
		m_text.word_wrap=true;
	}

	function on_show()
	{
	
		system("/usr/local/bin/get_ip_address.sh");

		m_text.msg = get_machine_information();

		m_text.visible=true;
	}

	function on_hide()
	{
		m_text.visible=false;
	}

	function on_scroll_up()
	{
		m_text.first_line_hint--;
	}

	function on_scroll_down()
	{
		m_text.first_line_hint++;
	}
}

fe.plugin[ "Show IP Address" ] <- ShowIpAddress();
