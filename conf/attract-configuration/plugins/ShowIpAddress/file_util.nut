///////////////////////////////////////////////////
//
// Attract-Mode Frontend - History.dat plugin
//
// File utilities
//
///////////////////////////////////////////////////
const READ_BLOCK_SIZE=80960;
local next_ln_overflow=""; // used by the get_next_ln() function
local idx_path = FeConfigDirectory + "history.idx/";
local loaded_idx = {};

//
// Write a single line of output to f
//
function write_ln( f, line )
{
	local b = blob( line.len() );

	for (local i=0; i<line.len(); i++)
		b.writen( line[i], 'b' );

	f.writeblob( b );
}

//
// Get a single line of input from f
//
function get_next_ln( f )
{
	local ln = next_ln_overflow;
	next_ln_overflow="";
	while ( !f.eos() )
	{
		local char = f.readn( 'b' );
		if ( char == '\n' )
			return strip( ln );

		ln += char.tochar();
	}

	next_ln_overflow=ln;
	return "";
}

//
// Scan through f and return the next line starting with a "$"
//
function scan_for_ctrl_ln( f )
{
	local char;
	while ( !f.eos() )
	{
		char = f.readn( 'b' );
		if (( char == '\n' ) && ( !f.eos() ))
		{
			char = f.readn( 'b' );
			if ( char == '$' )
			{
				next_ln_overflow="$";
				return get_next_ln( f );
			}
		}
	}
	return "";
}

function get_machine_information()
{
	local histf = file("/tmp/machineinfo.txt", "rb" );
	local output = "";

	while ( !histf.eos() )
	{
		local blb = histf.readblob( READ_BLOCK_SIZE );
		while ( !blb.eos() )
		{
			local line = get_next_ln( blb );
			output += line;
			

		}
	}

	return output;
}


