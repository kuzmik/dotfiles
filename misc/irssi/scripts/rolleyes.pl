#! /usr/bin/perl

# rolleyes.pl | v0.01-IRSSI 
# Ported to irssi from xchat perl

# Written by Patrick "octalc0de" Xia

# Syntax:
# /command
# /command colorforeground
# /command foreground background
# /command foreground background outline

# Valid Commands: v rolleyes roll mad keke xd

use strict;
my @data;

Irssi::command_bind("roll", "rolleyes");
Irssi::command_bind("rolleyes", "rolleyes");
Irssi::command_bind("keke", "keke");
Irssi::command_bind("v", "v");
Irssi::command_bind("xd", "xd");
Irssi::command_bind("mad", "mad");
Irssi::command_bind("cool", "cool");
Irssi::command_bind("dance", "dance");
Irssi::command_bind("frown", "frown");
Irssi::command_bind("rolleye", "rolleye");
Irssi::command_bind("smile", "smile");
Irssi::command_bind("what", "what");

initialize();

sub initialize {
  Irssi::print("[rolleyes] Loaded\n");
  Irssi::print("[rolleyes] Valid Commands: v rolleyes mad keke xd mad cool dance frown rolleye smile what\n");
}

sub rolleyes {
  my ($args, $server, $witem) = @_;
  my $fcolor = 3;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  restoreData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}
sub keke {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  kekeData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}
sub v {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  vData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}
sub xd {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  xdData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}
sub mad {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  madData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}sub cool {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  coolData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}
sub dance {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  danceData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}
sub frown {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  frownData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}
sub rolleye {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  rolleyeData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}
sub smile {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  smileData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}
sub what {
  my ($args, $server, $witem) = @_;
  my $fcolor = 8;
  my $bcolor = 0;
  my $kcolor = 1;
  my @t;
  @t = split(" ", $args);
  $t[0] && ($fcolor = findColor($t[0]));
  $t[1] && ($bcolor = findColor($t[1]));
  $t[2] && ($kcolor = findColor($t[2]));
  $fcolor = "\003".$fcolor.",".$fcolor;
  $bcolor = "\003".$bcolor.",".$bcolor;
  $kcolor = "\003". $kcolor.",".$kcolor;
  whatData();
  foreach (@data) {
    s/B/$bcolor/g;
    s/F/$fcolor/g;
    s/K/$kcolor/g;
    $witem->command("say $_");
  }
  Irssi::signal_stop();
}

sub findColor {
  $_ = $_[0];
  lc;
  /white/ && return 0;
  /black/ && return 1;
  /blue/ && return 2;
  /green/ && return 3;
  /red/ && return 4;
  /magenta/ && return 6;
  /orange/ &&  return 7;
  /yellow/ && return 8;
  /teal/ && return 10;
  /cyan/ && return 11;
  return 3;
}


sub restoreData {
$data[0] = "BXXXXXXXXXXKXXXXXXXXXXBXXXXXXXXXX";
$data[1] = "BXXXXXXKXXXXFXXXXXXXXXXKXXXXBXXXXXX";
$data[2] = "BXXXXKXXFXXXXXXXXXXXXXXXXXXKXXBXXXX";
$data[3] = "BXXKXXFXXXXKXXFXXXXXXXXKXXFXXXXXXKXXBXX";
$data[4] = "BXXKXXFXXKXXXXXXXXFXXKXXXXXXXXFXXKXXBXX";
$data[5] = "KXXFXXKXXBXXKXXXXBXXKXXBXXKXXXXBXXKXXFXXKXX";
$data[6] = "KXXFXXKXXBXXXXXXXXKXXBXXXXXXXXKXXFXXKXX";
$data[7] = "KXXFXXXXKXXBXXXXKXXFXXKXXBXXXXKXXFXXXXKXX";
$data[8] = "KXXFXXXXXXKXXXXFXXXXXXKXXXXFXXXXXXKXX";
$data[9] = "KXXFXXXXXXXXXXXXXXXXXXXXXXXXXXKXX";
$data[10] = "BXXKXXFXXXXXXXXXXXXXXXXKXXFXXXXKXXBXX";
$data[11] = "BXXKXXFXXXXXXKXXXXXXXXXXFXXXXXXKXXBXX";
$data[12] = "BXXXXKXXFXXXXXXXXXXXXXXXXXXKXXBXXXX";
$data[13] = "BXXXXXXKXXXXFXXXXXXXXXXKXXXXBXXXXXX";
$data[14] = "BXXXXXXXXXXKXXXXXXXXXXBXXXXXXXXXX";
}

sub kekeData {
  $data[0] = "BXXXXXXXXXXKXXXXXXXXXXBXXXXXXXXXX";
  $data[1] = "BXXXXXXKXXXXFXXXXXXXXXXKXXXXBXXXXXX";
  $data[2] = "BXXXXKXXFXXXXXXXXXXXXXXXXXXKXXBXXXX";
  $data[3] = "BXXKXXFXXXXXXXXXXXXXXXXXXXXXXKXXBXX";
  $data[4] = "BXXKXXFXXXXKXXFXXXXXXXXXXKXXFXXXXKXXBXX";
  $data[5] = "KXXFXXXXKXXFXXKXXFXXXXXXKXXFXXKXXFXXXXKXX";
  $data[6] = "KXXFXXKXXFXXXXXXKXXFXXKXXFXXXXXXKXXFXXKXX";
  $data[7] = "KXXFXXXXXXXXXXXXXXXXXXXXXXXXXXKXX";
  $data[8] = "KXXFXXXXXXXXXXXXXXXXXXXXXXXXXXKXXK";
  $data[9] = "KXXFXXXXKXXFXXXXXXXXXXXXXXKXXFXXXXKXX";
  $data[10] = "BXXKXXFXXXXKXXFXXXXXXXXXXKXXFXXXXKXXBXX";
  $data[11] = "BXXKXXFXXXXXXKXXXXXXXXXXFXXXXXXKXXBXX";
  $data[12] = "BXXXXKXXFXXXXXXXXXXXXXXXXXXKXXBXXXX";
  $data[13] = "BXXXXXXKXXXXFXXXXXXXXXXKXXXXBXXXXXX";
  $data[14] = "BXXXXXXXXXXKXXXXXXXXXXBXXXXXXXXXX";
}

sub vData {
  $data[0] = "BXXXXXKXXXXXBXXXXX";
  $data[1] = "BXXXKXXFXXXXXKXXBXXX";
  $data[2] = "BXXKXFXXXXXXXXXKXBXX";
  $data[3] = "BXKXFXXXXXXKXXFXXXKXBX";
  $data[4] = "BXKXFXXXXXXKXXFXXXXKX";
  $data[5] = "KXFXXXKXXFXXXXXXKXXX";
  $data[6] = "KXFXXXKXXFXXXXKXXBXXX";
  $data[7] = "KXFXXXXXXXKXXBXXXXX";
  $data[8] = "KXFXXXXXKXXBXXXXXXX";
  $data[9] = "KXFXXXKXXBXXXXXXXXX";
  $data[10] = "BXKXFXXXXKXXXBXXXXXX";
  $data[11] = "BXKXFXXXXXXXKXXXBXXX";
  $data[12] = "BXXKXFXXXXXXXXXKXXBX";
  $data[13] = "BXXXKXXFXXXXXXKXXBXX";
  $data[14] = "BXXXXXKXXXXXXBXXXX";
  foreach (@data) {
    s/X/XX/g;
  }
}

sub xdData {
  $data[0] = "BXXXXXKXXXXXBXXXXX";
  $data[1] = "BXXXKXXFXXXXXKXXBXXX";
  $data[2] = "BXXKXXFXXXXXXXKXXBXX";
  $data[3] = "BXKXFXXKXXFXXXKXXFXXKXBX";
  $data[4] = "BXKXFXXXXKXXXFXXXXKXBX";
  $data[5] = "KXFXXXKXXFXXXKXXFXXXKX";
  $data[6] = "KXFXKXXFXXXXXXXKXXFXKX";
  $data[7] = "KXFXXXXXXXXXXXXXKX";
  $data[8] = "KXFXXKXXXXXXXXXFXXKX";
  $data[9] = "KXFXXKXBXXXXXXXKXFXXKX";
  $data[10] = "BXKXFXKXBXXXXXXXKXFXKXBX";
  $data[11] = "BXKXFXXKXBXXXXXKXFXXKXBX";
  $data[12] = "BXXKXFXXKXXXXXFXXKXBXX";
  $data[13] = "BXXXKXXFXXXXXKXXBXXX";
  $data[14] = "BXXXXXKXXXXXBXXXXX";
  foreach (@data) { s/X/XX/g; }
}

sub madData {
  $data[0] = "BXXXXXKXXXXXBXXXXX";
  $data[1] = "BXXXKXXFXXXXXKXXBXXX";
  $data[2] = "BXXKXFXXKXFXXXKXFXXKXBXX";
  $data[3] = "BXKXFXXXXKXFXKXFXXXXKXBX";
  $data[4] = "BXKXFXXKXXFXKXFXKXXFXXKXBX";
  $data[5] = "KXFXXXKXXFXXXKXXFXXXKX";
  $data[6] = "KXFXXXXXXXXXXXXXKXF";
  $data[7] = "KXFXXXXXXXXXXXXXKX";
  $data[8] = "KXFXXXXKXXXXXFXXXXKX";
  $data[9] = "KXFXXXKXFXXXXXKXFXXXKX";
  $data[10] = "BXKXFXKXFXXXXXXXKXFXKXBX";
  $data[11] = "BXKXFXXXXXXXXXXXKXBX";
  $data[12] = "BXXKXFXXXXXXXXXKXBXX";
  $data[13] = "BXXXKXXFXXXXXKXXBXXX";
  $data[14] = "BXXXXXKXXXXXBXXXXX";
  foreach (@data) { s/X/XX/g; }
}


sub coolData {
  $data[0] = "BXXXXXKXXXXXBXXXXX";
  $data[1] = "BXXXKXXFXXXXXKXXBXXX";
  $data[2] = "BXXKXFXXXXXXXXXKXBXX";
  $data[3] = "BXKXFXXXXXXXXXXXKXBX";
  $data[4] = "BXKXFXXKXXFXXXKXXFXXKXBX";
  $data[5] = "KXXXXXBXKXFXKXXBXKXXXX";
  $data[6] = "KXFXXKXBXKXXXXBXKXXFXXKX";
  $data[7] = "KXFXXXKXXFXXXKXXFXXXKX";
  $data[8] = "KXFXXXXXXXXXXXXXKX";
  $data[9] = "KXFXXXXXXXXXXXXXKXB";
  $data[10] = "BXKXFXXKXFXXXXXKXFXXKXBX";
  $data[11] = "BXKXFXXXKXXXXXFXXXKXBX";
  $data[12] = "BXXKXFXXXXXXXXXKXBXX";
  $data[13] = "BXXXKXXFXXXXXKXXBXXX";
  $data[14] = "BXXXXXKXXXXXBXXXXX";foreach (@data) { s/X/XX/g; }

}

sub danceData {
  $data[0] = "BXXXXXXXKXXXXXBXXXXXXXXX";
  $data[1] = "BXXXXXKXXFXXXXXKXXBXXXXXXX";
  $data[2] = "BXXXXKXFXXXXXXXXXKXBXXXXXX";
  $data[3] = "BXXXKXFXXXXXXXXXXXKXBXXXXX";
  $data[4] = "BXXXKXFXXKXXFXXXKXXFXXKXBXXXXX";
  $data[5] = "BXXKXFXXXKXXFXXXKXXFXXXKXBXXXX";
  $data[6] = "BXXKXFXXXXXXXXXXXXXKXBXXXX";
  $data[7] = "BXXKXFXXXXXXXXXXXXXKXBXXXXB";
  $data[8] = "KXXXXXXXXXXXXXXFXXKXBXXXX";
  $data[9] = "KXFXXXKXXXXXXXXXXFXXKXBXXXX";
  $data[10] = "KXFXXXKXFXKXXXXXXXFXXKXXXXXKX";
  $data[11] = "KXFXXXKXFXXKXXXXXFXXXKXXFXXXKX";
  $data[12] = "KXXXXXFXXXXXXXXXKXBXKXFXXXKX";
  $data[13] = "BXXXXXKXXFXXXXXKXXBXXKXFXXXKX";
  $data[14] = "BXXXXXXXKXXXXXBXXXXKXXXXX";foreach (@data) { s/X/XX/g; }

}

sub frownData {
  $data[0] = "BXXXXXKXXXXXBXXXXX";
  $data[1] = "BXXXKXXFXXXXXKXXBXXX";
  $data[2] = "BXXKXFXXKXFXXXKXFXXKXBXX";
  $data[3] = "BXKXFXXKXFXXXXXKXFXXKXBX";
  $data[4] = "BXKXFXKXFXXXXXXXKXFXKXBX";
  $data[5] = "KXFXXXKXXFXXXKXXFXXXKX";
  $data[6] = "KXFXXXKXXFXXXKXXFXXXKX";
  $data[7] = "KXFXXXXXXXXXXXXXKXB";
  $data[8] = "KXFXXXXXXXXXXXXXKX";
  $data[9] = "KXFXXXXKXXXXXFXXXXKX";
  $data[10] = "BXKXFXXKXFXXXXXKXFXXKXBX";
  $data[11] = "BXKXFXXXXXXXXXXXKXBX";
  $data[12] = "BXXKXFXXXXXXXXXKXBXX";
  $data[13] = "BXXXKXXFXXXXXKXXBXXX";
  $data[14] = "BXXXXXKXXXXXBXXXXX";foreach (@data) { s/X/XX/g; }

}
sub rolleyeData {
  $data[0] = "BXXXXXKXXXXXBXXXXX";
  $data[1] = "BXXXKXXFXXXXXKXXBXXX";
  $data[2] = "BXXKXFXXXXXXXXXKXBXX";
  $data[3] = "BXKXFXXXXXKXXFXXXXKXBX";
  $data[4] = "BXKXFXXXXKXXXXFXXXKXBX";
  $data[5] = "KXFXXXXKXBXKXXBXKXFXXXKX";
  $data[6] = "KXFXXXXKXBXXXXKXFXXXKX";
  $data[7] = "KXFXXXXXKXBXXKXFXXXXKX";
  $data[8] = "KXFXXXXXXKXXFXXXXXKX";
  $data[9] = "KXFXXXXXXXXXXXXXKX";
  $data[10] = "BXKXFXKXXFXXXXXXKXFXKXBX";
  $data[11] = "BXKXFXXKXXXXXXXFXXKXBX";
  $data[12] = "BXXKXFXXXKXXXFXXXKXBXX";
  $data[13] = "BXXXKXXFXXXXXKXXBXXX";
  $data[14] = "BXXXXXKXXXXXBXXXXX";foreach (@data) { s/X/XX/g; }
}



sub smileData {
  $data[0] = "BXXXXXKXXXXXBXXXXX";
  $data[1] = "BXXXKXXFXXXXXKXXBXXX";
  $data[2] = "BXXKXFXXXXXXXXXKXBXX";
  $data[3] = "BXKXFXXXXXXXXXXXKXBX";
  $data[4] = "BXKXFXXKXXFXXXKXXFXXKXBX";
  $data[5] = "KXFXXXKXXFXXXKXXFXXXKX";
  $data[6] = "KXFXXXXXXXXXXXXXKX";
  $data[7] = "KXFXXXXXXXXXXXXXKXF";
  $data[8] = "KXFXXXXXXXXXXXXXKX";
  $data[9] = "KXFXXKXFXXXXXXXKXFXXKX";
  $data[10] = "BXKXFXXKXFXXXXXKXFXXKXBX";
  $data[11] = "BXKXFXXXKXXXXXFXXXKXBX";
  $data[12] = "BXXKXFXXXXXXXXXKXBXX";
  $data[13] = "BXXXKXXFXXXXXKXXBXXX";
  $data[14] = "BXXXXXKXXXXXBXXXXX";foreach (@data) { s/X/XX/g; }

}

sub whatData {
  $data[0] = "BXXXXXKXXXXXBXXXXX";
  $data[1] = "BXXXKXXFXXXXXKXXBXXX";
  $data[2] = "BXXKXFXXXXXXXXXKXBXX";
  $data[3] = "BXKXFXXKXXFXXXKXXFXXKXBX";
  $data[4] = "BXKXFXKXFXXKXFXKXFXXKXFXKXBX";
  $data[5] = "KXFXKXXXXXXXXXXXFXKX";
  $data[6] = "KXFXKXBXKXXBXKXBXKXXBXKXFXKX";
  $data[7] = "KXFXXKXBXXKXFXKXBXXKXFXXKX";
  $data[8] = "KXFXXXKXXFXXXKXXFXXXKX";
  $data[9] = "KXFXXXXXXKXFXXXXXXKX";
  $data[10] = "BXKXFXXXXKXFXKXFXXXXKXBX";
  $data[11] = "BXKXFXXXXKXXXFXXXXKXBX";
  $data[12] = "BXXKXFXXXXXXXXXKXBXX";
  $data[13] = "BXXXKXXFXXXXXKXXBXXX";
  $data[14] = "BXXXXXKXXXXXBXXXXX";foreach (@data) { s/X/XX/g; }

}
