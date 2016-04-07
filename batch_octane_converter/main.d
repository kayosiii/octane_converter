module main;

import std.stdio;
import std.file;
import std.path;
import std.range : array,take;
import std.algorithm : find, canFind;
import std.conv : to;
import std.process : executeShell;
import std.string : replace;

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

	string[string] exes;
	foreach(exe; max_executables)
	{
		if (canFind(exe,"2014")) exes["2014"] = exe;
		else if (canFind(exe,"2015")) exes["2015"] = exe;
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
		auto mat_file = replace(max_file, ".max", ".mat");
		if (!mat_file.exists)
		{
			string import_cmd = format("\"%s\" \"%s\" -u \"%s\"", exes["2014"], max_file, import_script);
			executeShell(import_cmd);	
		}
	}
	foreach (max_file; max_files)
	{
		auto mat_file = replace(max_file, ".max", ".mat");
		if (mat_file.exists)
		{
			string export_cmd = format("\"%s\" \"%s\" -u \"%s\"",exes["2015"], max_file, export_script);
			executeShell(export_cmd);
		}
	}

	// Prints "Hello World" string in console
	writeln("Hello World!");
	
	// Lets the user press <Return> before program returns
	stdin.readln();
}

