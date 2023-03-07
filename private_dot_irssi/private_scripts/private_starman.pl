use vars qw($VERSION %IRSSI);
use strict;
use Irssi;

$VERSION = '0.47';
%IRSSI = (
    authors     => 'oublinet idiots',
    contact     => 'irc://irc.oublinet.net/#oublinet',
    name        => 'starman',
    description => 'lame, beyond lame.. so fucking lame, my dick refuses to erect itself.',
    license     => 'zul',
    url         => 'http://misanthropia.nu',
    changed     => 'tue sept 11 2001 21:15 est'
);

my @colors = (2, 15, 3, 14, 4, 13, 5, 12, 6, 11, 7, 10, 8, 9, 9, 8, 10, 7, 11, 6, 12, 5, 13, 4, 14, 3, 15, 2);

###
#   foreground (fg)     background (bg)
#-------------------------------------------------------
# 0     white               light gray   + blinking fg
# 1     black               black
# 2     blue                blue
# 3     green               green
# 4     light red           red          + blinking fg
# 5     red                 red
# 6     magenta (purple)    magenta
# 7     orange              orange
# 8     yellow              orange       + blinking fg
# 9     light green         green        + blinking fg
# 10    cyan                cyan
# 11    light cyan          cyan         + blinking fg
# 12    light blue          blue         + blinking fg
# 13    light magenta       magenta      + blinking fg
# 14    gray                black        + blinking fg
# 15    light gray          light gray
#
# \002  toggle bold
# \00?  flashing (blinking)
# \017  reset
# \026  toggle reverse foreground and background
# \037  toggle underline
###

# str colorize($string)
# returns random-coloured string
# no args
sub americanize {
    my ($string) = @_;
    my $newstr = "";
    my $last = 255;
    my $color = 0;
    for (my $c = 0; $c < length($string); $c++) {
        my $char = substr($string, $c, 1);
        if ($char eq ' ') {
            $newstr .= $char;
            next;
        }
        while (($color = int(rand(scalar(@colors)))) == $last) {};
        $last = $color;
        $newstr .= "\003";
        $newstr .= sprintf("%02d", $colors[$color]);
        $newstr .= (($char eq ",") ? ",," : $char);
    }
    $newstr .= "\017"; #return to normal color
    return $newstr;
}

# str colorize($string)
# returns random-coloured string
# no args
sub colorize {
    my ($string) = @_;
    my $newstr = "";
    my $last = 255;
    my $color = 0;
    for (my $c = 0; $c < length($string); $c++) {
        my $char = substr($string, $c, 1);
        if ($char eq ' ') {
            $newstr .= $char;
            next;
        }
        while (($color = int(rand(scalar(@colors)))) == $last) {};
        $last = $color;
        $newstr .= "\003";
        $newstr .= sprintf("%02d", $colors[$color]);
        $newstr .= (($char eq ",") ? ",," : $char);
    }
    $newstr .= "\017"; #return to normal color
    return $newstr;
}

#############################################
#   ___        _     _ _ _   _ _____ _____  #
#  / _ \ _   _| |__ | (_) \ | | ____|_   _| #
# | | | | | | | '_ \| | |  \| |  _|   | |   #
# | |_| | |_| | |_) | | | |\  | |___  | |   #
#  \___/ \__,_|_.__/|_|_|_| \_|_____| |_|   #
#    wuz here m8!@#$%                       #
#############################################

# handles: /clist
# args: none
# returns: nothing
sub cmd_clist {
    Irssi::print("\00300this\017 is color 0");
    Irssi::print("\00301this\017 is color 1");
    Irssi::print("\00302this\017 is color 2");
    Irssi::print("\00303this\017 is color 3");
    Irssi::print("\00304this\017 is color 4");
    Irssi::print("\00305this\017 is color 5");
    Irssi::print("\00306this\017 is color 6");
    Irssi::print("\00307this\017 is color 7");
    Irssi::print("\00308this\017 is color 8");
    Irssi::print("\00309this\017 is color 9");
    Irssi::print("\00310this\017 is color 10");
    Irssi::print("\00311this\017 is color 11");
    Irssi::print("\00312this\017 is color 12");
    Irssi::print("\00313this\017 is color 13");
    Irssi::print("\00314this\017 is color 14");
    Irssi::print("\00315this\017 is color 15");
}

# handles: /colsay
# args: text to colorize and say
# returns: arg1 randomly colorized
sub cmd_colsay {
    my ($text, $server, $witem) = @_;
    if (!$server || !$server->{connected}) {
        Irssi::print("Not connected to server");
        return;
    }
    return unless $witem;
    if ($witem->{type} eq "CHANNEL" || $witem->{type} eq "QUERY") {
        $witem->command("/msg " . $witem->{name} . " " . colorize($text));
    }
}

# handles: /colsay
# args: text to patriotiza and say
# returns: arg1 but AMERICA
sub cmd_usa {
        my ($text, $server, $witem) = @_;
        if (!$server || !$server->{connected}) {
                Irssi::print("Not connected to server");
                return;
        }
        return unless $witem;
        if ($witem->{type} eq "CHANNEL" || $witem->{type} eq "QUERY") {
                $witem->command("/msg " . $witem->{name} . " " . americanize($text));
        }
}

# handles: /nexagen
# args: username to pimp
# returns: nexagenusa money
sub cmd_nexagen {
    my ($name, $server, $witem) = @_;
    $name =~ s/^\s+//;
    $name =~ s/\s+$//;
    my $spam1 = "$name, I need to ask you a question that could be very lucrative to both of us. But first, think of all the people WE know who will answer 'YES' to this question..";
    my $spam2 = "If I could show you a way to lose all the fat you want, painlessly and effortlessly and make some money, probably some serious money, would that interest you?";
    if (!$server || !$server->{connected}) {
        Irssi::print("Not connected to a server you dipshit.");
        return;
    }
    return unless $witem;
    if ($witem->{type} eq "CHANNEL" || $witem->{type} eq "QUERY") {
        $witem->command("/msg " . $witem->{name} . " " . $spam1);
        $witem->command("/me gives $name a few minutes to ponder");
        $witem->command("/msg " . $witem->{name} . " " . $spam2);
    }
}

# handles: /nexagens
# args: username to pimp
# returns: nexagenusa money
sub cmd_nexagens {
  my ($name, $server, $witem) = @_;
  $name =~ s/^\s+//;
  $name =~ s/\s+$//;
  my $spam1 = "$name, necesito preguntarle algo que podría ser bastante lucrativo para ambos. Antes de responder, piense en todas las personas que CONOCEMOS que contestarían esta pregunta con un 'Si'";
  my $spam2 = "Si pudiera mostrarle una manera de perder toda la grasa que desee sin dolor ni esfuerzo y ganar dinero, probablemente mucho dinero, ¿le interesaría?";

  if (!$server || !$server->{connected}) {
    Irssi::print("Not connected to a server you dipshit.");
    return;
  }
  return unless $witem;
  if ($witem->{type} eq "CHANNEL" || $witem->{type} eq "QUERY") {
    $witem->command("/msg " . $witem->{name} . " " . $spam1);
    $witem->command("/me [Concédales un minuto]");
    $witem->command("/msg " . $witem->{name} . " " . $spam2);
  }
}

# handles: /starwhack
# args: not right now
# returns: nothing
sub cmd_starwhack {
    my ($arguments, $server, $witem) = @_;
    $server->command("action " . $witem->{name} . " tHiNKZ \002" . $witem->{name} . "\017 DesERVeS uH sTArMan!?@(tm)! \(oh gNO!@# " . colorize("eEK!?") . ")");
    $server->command("msg " . $witem->{name} . " \00308__/\\__\017 " . colorize("YOu'vE"));
    $server->command("msg " . $witem->{name} . " \00308\\\ \00300oO \00308/\017 " .  colorize("beEN"));
    $server->command("msg " . $witem->{name} . " \00308/_\00304\\\/\00308_\\\017 " . colorize("sTAr'd"));
    $server->command("msg " . $witem->{name} . " \00308  \\/\017   " . colorize("mOtheRFaWKur!?@"));
    $server->command("msg " . $witem->{name} . " \002" .$witem->{name} . "\017, taKe THAt BItZH!@#? " . colorize("aYAaYEYE?!@3"));
}

# handles: /zakwak
# args: none
# returns: it's like starman, but about zak
sub cmd_zakwak {
    my ($arguments, $server, $witem) = @_;
    $server->command("action " . $witem->{name} . " tHiNKZ \002" . $witem->{name} . "\017 DesERVeS uH zAkMan!?@(tm)! \(oh gNO!@# " . colorize("eEK!?") . ")");
    $server->command("msg " . $witem->{name} . "        \00308/\\");
    $server->command("msg " . $witem->{name} . "       \00308//\\\\");
    $server->command("msg " . $witem->{name} . "  \00308____//__\\\\____");
    $server->command("msg " . $witem->{name} . "  \00308\\.-//----\\\\-./   \017" . colorize("WhaT?? sA CosTz"));
    $server->command("msg " . $witem->{name} . "   \00308\\v/      \\v/    \017" . colorize("10 BuX??!!!1one!!1"));
    $server->command("msg " . $witem->{name} . "   \00308/\\\\      //\\    \017" . colorize("i DoN'T evEn HavE a JoB!@!@#?"));
    $server->command("msg " . $witem->{name} . "  \00308//_\\\\____//_\\\\   \017" . colorize("iLl juSt SmOkE PoT inSteAD!!"));
    $server->command("msg " . $witem->{name} . " \00308'----\\\\--//----'");
    $server->command("msg " . $witem->{name} . "       \00308\\\\//");
    $server->command("msg " . $witem->{name} . "        \00308\\/");
    $server->command("msg " . $witem->{name} . " \002" . $witem->{name} . "\017, sHalOm, bITzH!@#?? " . colorize("aYAaYEYE?!@3"));
}

# handles: /fuckgno
# args: none
# returns: nothing
sub cmd_fuckgno {
    my ($arguments, $server, $witem) = @_;
    $server->command("msg " . $witem->{name} . " oH HeLl \002FUck\017 NO!@?3 i'VE goT \037StaRmAN\037(tM) iN mUH sEMeN!2? -- eEK!@");
}

# handles: /lol
# args: none
# returns: nothing
sub cmd_lol {
    my ($arguments, $server, $witem) = @_;
    $server->command("msg " . $witem->{name} . " \002\00306((((\002\00304L\00309aughing \00304O\00309ut \00304L\00309oud\002\00306))))\002\017");
}

# handles /robot
# arg: text for robot to say
# returns: nothing
sub cmd_robot {
    my ($arguments, $server, $witem) = @_;
    my $words = $arguments ? $arguments : "i am a robot. feed me dick!";
    $server->command("msg " . $witem->{name} . "       .-----.");
    $server->command("msg " . $witem->{name} . "       | oO  |");
    $server->command("msg " . $witem->{name} . "       | --  | --- $words");
    $server->command("msg " . $witem->{name} . "  _____|_____|_____");
    $server->command("msg " . $witem->{name} . " |_____|     |_____|");
    $server->command("msg " . $witem->{name} . "       |     |");
    $server->command("msg " . $witem->{name} . "       |_____|");
    $server->command("msg " . $witem->{name} . "       |  |  |");
    $server->command("msg " . $witem->{name} . "       |  |  |");
    $server->command("msg " . $witem->{name} . "       |__|__|");
}

# handles: /lolz
# args: none
# returns: nothing
sub cmd_lolz {
    my ($arguments, $server, $witem) = @_;
    $server->command("msg " . $witem->{name} . " " . colorize("#       ####  #      ######"));
    $server->command("msg " . $witem->{name} . " " . colorize("#      #    # #          #"));
    $server->command("msg " . $witem->{name} . " " . colorize("#      #    # #         #"));
    $server->command("msg " . $witem->{name} . " " . colorize("#      #    # #        #"));
    $server->command("msg " . $witem->{name} . " " . colorize("#      #    # #       #"));
    $server->command("msg " . $witem->{name} . " " . colorize("######  ####  ###### ######"));
}

### register everything
Irssi::command_bind("lol", "cmd_lol");
Irssi::command_bind("lolz", "cmd_lolz");
Irssi::command_bind("clist", "cmd_clist");
Irssi::command_bind("robot", "cmd_robot");
Irssi::command_bind("colsay", "cmd_colsay");
Irssi::command_bind("zakwak", "cmd_zakwak");
Irssi::command_bind("nexagen", "cmd_nexagen");
Irssi::command_bind("nexagen2", "cmd_nexagens");
Irssi::command_bind("fuckgno", "cmd_fuckgno");
Irssi::command_bind("starwhack", "cmd_starwhack");
Irssi::command_bind("usa", "cmd_usa");
