module main;

import std.stdio;
import std.file;
import std.path;
import std.range : array,take;
import std.algorithm : find, canFind;
import std.conv : to;

void main(string[] args)
{
	version(linux)
	{
		auto max_executables = dirEntries("/media/Windows7/Program Files/Autodesk/","*3dsmax.exe",SpanMode.depth).array;
	}
	else version(Windows)
	{
		auto max_executables = dirEntries("C:\\Program Files\\Autodesk\\","*3dsmax.exe",SpanMode.depth);
	}
	auto max2014 = find(max_executables,"2014");
	assert(max2014.length > 0,"failed to find 2014\n");

	foreach(entry; max_executables)
	{
		writeln(entry);
	}
	version(linux)
	{
		auto import_script = "/media/danni/network/resources/Temp/danni/OctaneImporter/importer.ms";
		auto export_script = "/media/danni/network/resources/Temp/danni/OctaneImporter/exporter.ms";
		auto max_files = dirEntries("/media/danni/network/resources/Temp/danni/maxfiles/","*.max",SpanMode.depth);
	}
	version(Windows)
	{
		auto import_script = "E:\\Temp\\Danni\\OctaneImporter\\importer.ms";
		auto export_script = "E:\\Temp\\Danni\\OctaneImporter\\exporter.ms";
		auto max_files = dirEntries(".","*.max",SpanMode.depth);
	}

	foreach (max_file; max_files)
	{

	}

	// Prints "Hello World" string in console
	writeln("Hello World!");
	
	// Lets the user press <Return> before program returns
	stdin.readln();
}

