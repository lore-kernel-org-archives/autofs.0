From: Xen <list@xenhideout.nl>
Subject: Re: documentation issues
Date: Wed, 06 Jul 2016 06:47:20 +0200
Message-ID: <120efa5371880caa1f603fb7a4cded84@dds.nl>
References: <cec586e96030cbbc150886909bf34a45@dds.nl>
 <1467766653.4580.46.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1467766653.4580.46.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Autofs <autofs@vger.kernel.org>

Ian Kent schreef op 06-07-2016 2:57:
> On Tue, 2016-07-05 at 23:17 +0200, Xen wrote:
>> Hi,
>> 
>> a few things.
>> 
>> A user attempting to use autofs for the first time will assume that
>> autofs will mount mount poins that already exist. Nowhere is it stated
>> that mount points will only get created when accessed (through a 
>> "direct
>> path").
> 
> Umm, "direct path" is an unfortunate choice here as you are talking 
> about autofs
> indirect mount maps.
> 
> Direct mount maps create a mount trigger for each map entry and so show 
> up as
> mount points in the file system.
> 
> There are reasons for it being this way.

So you are berating me for choice of words ;-).

The only difference between direct and indirect seems to be that with 
direct the share is mounted "directly" on top of the specified mount 
point (actually, none is specified, it is mounted on the key returned 
from the map) and as a result it is not possible to have lazy 
initialization (unless you merged e.g. the root filesystem with an 
overlay filesystem) and so you are required to create this mountpoint, 
whereas with "indirect" you control the mount point itself and can 
choose whether to create the subdirectories or not (if you can acquire a 
list). "Directly" seems to mean "directly on the filesystem" whereas 
"indirectly" seems to mean: inside our own little enclave.

And always as a subdirectory of that. Not even technically necessary, 
you could even have a "indirect map" that triggered mounting I guess, 
don't know. I guess not.



> 
>> 
>> Such a user (such as me) trying to use this thing (even with a 
>> tutorial
>> on Ubuntu site) will be flabbergasted that nothing happens; he/she
>> expects mount entries to appear, but nothing happens.
>> 
>> This renders the "nobrowse" default dysfunctional for a desktop user,
>> who expects to see something before going there. It only works for
>> automated systems, really.
> 
> Your assuming that autofs primary usage is targeted at the desktop.
> It's often not the best use case for that.
> 
> There are other more suitable automount alternatives for GUI desktops.

Linus Torvalds says he developed Linux as a desktop OS. And how 
chagrined he is that it didn't succeed in just that. Well, now we know 
the reason for that ;-).

I know there are probably alternatives; but they are mostly useless for 
someone who wants to do it on his own. Desktop environments often do not 
even have mount operations on directories (even) when they are described 
in fstab. There is no other way that I know of to automatically mount 
e.g. samba shares, unless you navigate directly to it (and then they end 
up in some weird location in the filesystem, if at all). There is 
usually also no "user based" fstab; where you can describe mounts 
specifically for your user, that are then mounted through e.g. fuse, or 
something else that can do suid. Perhaps you mean udisks or udisksd or 
udisksctl but I'm not even sure that supports network-filesystems, they 
are certainly not shown in udisksctl status.

Dolphin can not actually mount a share to some fixed location, the Nemo 
I am using doesn't even succeed in browsing the network. For me there 
are only two solutions that I see, either fstab or autofs. Once you know 
how to do it, running /etc/auto.smb <host> quickly returns a list of 
shares (if you've set the credentials file) that you can then edit to 
become a static map with the browse option.

I do not see what is better suited currently to auto-mounting 
samba-shares. Anything that would work well, would work from both the 
shell and the GUI, in that the systems have to be linked, and ideally 
what the GUI does is stored in state files that work equally well from 
the shell. Any persistent mount would have to be stored somewhere on 
disk. Then the link would need to be automounted, OR mounted through 
e.g. libpam-mount. There is nothing wrong with mounting upon logon. And 
that allows for specific user-dependent stuff. (An automount depending 
on what user first accesses it, is problematic). (As for Samba). So 
perhaps logon-mounts are better suited (just restore the mount from the 
previous session, in that sense) because the $UID problem is hard to 
solve for autofs, you must either duplicate all entries, and hardcore 
the UIDs you need, for every user, or I don't know what, prevent other 
users (including root) from accessing the share you need. You'd 
basically need map files in auto.master.d for every user, including a 
map file for each person to specify the shares, if you want browsable, 
or a modified version of auto.smb that mounts individual shares when 
accessed. (In the latter case you'd have no browse map).

But this script doesn't know what it is being called on, so now you need 
a variable I guess for each of those .d/ files, so that their entries 
would be something like:

/media/<user>/nas  /etc/auto-short.smb -Duser=<user> which would then be 
used for the samba $UID.

If there is a better way to do this, I don't know. I see no alternatives 
other than libpam-mount and of course some GUI could do it, but then 
you'd really just have a form of duplicated functionality between autofs 
and it.


>> - browse only works for static maps, and what person with a static map
>> is going to run into performance issues when mount points are created 
>> in
>> advance? Can we please remove this from the default config? (turning 
>> it
>> off).
> 
> Well, quite a lot of current users actually.
> 
> Consider what can happen with a few hundred or a few thousand entries 
> in an
> indirect map.

Alright, but what indirect maps can cause browse tables to be shown? 
Only static maps, right? A programmatic map can only return a single 
entry. I have not looked into the other ones, but I suppose LDAP is more 
like a programmatic map than anything else.

So then consider that we only use a static map here. An actual file with 
thousands of entries? Of course it can happen. But what would be the 
point of that still (as opposed to LDAP or programmatic).


> Even though the browse option was added it has a specific set of 
> problems.
> 
> First the kernel does not know if you are just listing a directory or 
> actually
> need to mount something.

Do you mean the directory containing the (indirect) entries (e.g. the 
managed directory) or one of those entries themselves?

> So at the moment, certain types of system call (the module can't know 
> the exact
> system call either) don't cause a call back to perform a mount but 
> often user
> space will later make a system call that will cause a mount to occur 
> anyway.
> 
> That leads to sometimes seeing directories that are those of the autofs 
> file
> system not those of the mounted file system, so they have completely 
> different
> attributes to those after an automount has been done, a problem in 
> itself.

Oh... such as ownership etc.

The typical "I mount this, and now suddenly it is not root.root but 
xen.staff".

> And, it can often lead to a mount storm, mounting everything in the 
> directory.

But how can that happen? If I do; "for f in *; ls $f; done" sure.


> 
> OK for a few dozen mounts in a map but really bad for anything with 
> more than a
> few hundred entries.

After thinking a little I came up with what could perhaps be some 
default use case. You have terminals mounting home directories. On the 
"terminal machine" you may have just a single user. Through LDAP you 
find the home directory. There is obviously no sense for all users in 
the LDAP system to now have precreated mount points. The only thing that 
could make sense is to have an "invisible" user directory that now gets 
mounted.

I can see no reason to have hundreds of mount points in a directory 
unless they cannot conform to a specific pattern. If they follow a 
pattern, it is likely that only a few of them need to be mounted at any 
time. In that case being able to browse it seems nonsensical. An 
aggregate of hundreds of different mounts at the same time seems very 
weird. Weird to have a diverse set of unique names to begin with. As if 
all of them were manually added in some way. If they aren't manually 
added, but automatically, then why have a static list? Would you not be 
better off putting that in a database? And if you'd have so many, we'd 
assume they could be different users, or different websites, etc. We 
also assume not all of them are going to be needed, just a subset. But 
so now you have a system on which this list is statically created but 
dynamically updated. This list sits on the disk of the local system. But 
you're not querying a database (could be just as easy) that could also 
store this list and return the entries one by one when needed. The 
static file is the database.

Seems an improper use case but yeah. I don't know how you can have a 
static list that is huge while not choosing to use a database to manage 
it. Because a static map; now you need routines to update it, delete 
entries from it.

Maybe I'm missing something here.


> Another reason for the default is that, because of this, historically 
> there was
> no "browse" option and this maintains what is (should be) expected.

Yeah I thought so, because of the comments near the timeout value. 
However that is a reason to never change anything ever. Someone 
mistakenly choosing "browse" will very quickly find out.

If this person really has hundreds of items in his list, he will notice 
within a second that they are all visible. If this person really has 
hundreds to thousands of items, he or she may also be expected to know 
the ins and outs of the system, and to be aware of the browse option, or 
be able to find out. This is not going to be a novice user.

On the other hand, anyone new to the system will have modest goals. 
However those modest goals are frustrated and refuted because the system 
is geared towards that professional that already knows everything, and 
for whom adding nobrowse, or changing the config file, would probably be 
a nobrainer. The new user however may be flabbergasted that it either 
does not work, or not the way she feels it should work (making a list, 
and then not seeing it in action).



>> - browse being turned off by default combined with a complete lack of
>> mention that you need to access these "nonexistent" directory paths /
>> components before you will be able to see them, turns autofs into a
>> complete mystery for someone who is not privy to the details yet.
> 
> It's been a long time for me so I probably have forgotten what it's 
> like for
> someone starting out.
> 
> And so, how would I know where in the man pages to put that so it gets 
> noticed
> by new users, perhaps from your perspective, you could point out a few 
> key
> places where it should be added, or better still send a patch.

This happens a lot, it is no ones fault. I guess people who knows the 
ins and outs of something usually jump smack in the middle, and forget 
to mention what the system is really like from the outside. A fish 
doesn't notice the water, we don't notice the air.

We are too much immersed in it.

I think there are 3-4 things I would explain.

First the auto.master file on my system mentions man autofs as a place 
for seeing the format of the (sub)map files. However there is nothing in 
there. So that part is missing, but in a sense the contents of auto.misc 
is already somewhat sufficient for that, but still annoying that there 
is no man page.

The second part is that it is often hard to understand what is meant by 
"key". In the master file, key means the mount point that supposedly 
already exists in the filesystem. In the sub-maps, key means the 
subdirectory but also the component of the path getting accessed by the 
user. Both types of files are called map files, and both kind of keys 
are called keys. This is aggravated by the fact that there is no man 
page for the sub-maps, that I know of . Auto.smb then speaks of a key, 
but it doesn't say what it is. Of course after a while you realize it is 
to be the host, but then you don't know how it knows about this host. 
Since at that point you don't realize that this is input from the 
filesystem (e.g. a stat operation) on "hidden directories" you are 
really clueless as to where this information is coming from ;-).

You don't imagine that every freaking access of a directory or path 
component in the managed directory is going to result in network access.

You could do a "for f in `seq 1 10000000`; do vdir $f; done" and have 
fun.

(Don't know if that would still be the case for "browse" maps).

So this hidden directory, secret door thing is really the most confusing 
of all.

It's somewhat similar to something I might like to do, but still you 
don't really expect it ;-).

So the 3-4 things are:

create a man page or section for the format of the sub-maps
indicate more clearly that programmatic maps in principle return a 
single entry
indicate that programmatic maps currently require access of a path 
component and that this path component (user action) is the key to the 
script.
indicate that this is true for "no browse" on "static maps" as well, and 
that directories are only created when they are accessed.
And that no-browse is the configured default.

Currently the documentation for the master map and for (indirect) 
sub-maps is really in auto.master and auto.misc.

Reading config files is usually a lot more pleasant than man pages ;-) 
so that's not such a huge problem, but you can't learn anything from a 
very limited set of examples either ;-).

For instance: direct map won't work if not prefixed with /, but will 
also not give error if not. Indirect map (I think) won't work if 
prefixed with /, but will also not give error if not.

I could say more but my thumb is hurting (infected) so I gotta quit 
this.

I don't mind writing documentation. But I'm not familiar yet with man 
pages and their technical structure and all.

I'll have to see. Thank you for the interest in any case :).


>> 
>> 
>> Further I would say that on a desktop OS, the most likely use case is
>> going to be this:
>> 
>> - have several shares in your home network
>> - want to access them through a GUI
>> - prefer automounting since mounting at boot can be problematic
>> - need to see them before you can access them in a GUI
>> - only alternative is "bookmarks" or "places" that work regardless of
>> the things not being visible/listed in the directory.
> 
> Either use a different automounting mechanism or use a direct mount 
> map.
> 
> That would satisfy all these needs, all be it with the map entries 
> always being
> mounted on access.
> 
> The limitation of these is you can't have a direct map path that is 
> within
> another automounted path, if you need to do that you need to use a more
> complicated setup.

I think that limitation indicates why using relative paths is so much 
more pleasant. A map file using relative files can be "moved around". A 
map file using absolute paths cannot.

Could you not make a direct map out of the key of the master file, and 
the keys of the sub-maps?

If there is really a need for huge static map files (I haven't studied 
LDAP) in principle all you need is a syntax to differentiate between the 
two, right.

/-         ( /this/is/my/abs/path )

or

/this/is/my/abs      ( -/path )

could be identical

normally ( /bla/bla ) indicates an absolute path and can only be used in 
a direct map, from what I've seen. You *could* cause it to turn this 
"indirect map" into a direct one.

ie. ( bla/bla ) == indirect
     ( /bla/bla ) == direct.

A direct map is always a static file right? But then it doesn't matter 
what part of the path is specified in what file.

Or

     ( bla/bla ) == indirect
     ( -/bla/bla ) == direct

So you get:

/start/of/the  (-/path )

or

/start/of/the/-  ( path )

Then any path in the master file ending with /- would be a direct path.

And would cause the (static) map file to be treated as direct.



> 
>> 
>> Then I will also say,
>> 
>> that there is no documentation on the format of the map files other 
>> than
>> auto.master. The documentation for map files is this:
> 
> That's not quite right.
> 
> Man page autofs(5) has a bit of information on both the Sun and amd 
> format maps.

Oh I am sorry. I think many users are not versed in the numbers for the 
man pages. I for one do not notice the difference and I almost never use 
one of those numbers. Sorry, I seriously missed that.

I only noticed just now because autofs(8) references autofs(5), and I'm 
like ....huh?

Okay, allright. Missed that.

Seriously bad system if you ask me, but okay.

So I guess you can have direct maps with LDAP etc. too.

I guess the wildcard also solves the many-user problem.

Well, but only for the sub-map. You couldn't get autofs to manage 
/media, so it needs to be /media/user/<aggregate> in which user can't 
suddenly be a wildcard unless you use a direct map. You could expand 
that to include the master file though:

/media/*/nas    /etc/nas-shares.map

And then in /etc/nas-shares.map:

share1   -fstype=xxx,uid=&   ://nas/share1
share2   -fstype=xxx,uid=&   ://nas/share2

I can't see whether LDAP supports browse, I assume it must, since it 
supports direct.




> By definition a program map can't know what keys may be passed to it.
> And, yes, even autofs(5) doesn't say explicitly that a program map 
> doesn't know
> what keys may be passed to it, perhaps that should be ammended.

In principle even a program map could read all of the available keys 
from whatever database it consults, and return all of them; or return 
something only (as it does now, perhaps) when a given key matches (is 
found).

If you wanted that you would need the program script to e.g. support a 
wildcard as parameter. Meaning, all scripts must then check for "*" to 
be passed to it, in order to return the full list that they can acquire 
(if even possible) or at least return an error of some kind to say that 
they don't support it.

You'd need a parameter for it, and any script would need to be aware of 
that parameter.

That's either gonna be a wildcard or something given on $2, in that case 
every existing script would already be compatible with it, since it 
simply disregards $2.

So, for instance, if $2 is "browse" the script may choose to return a 
browse map, or list of shares, with whatever options are available (it 
could even return the UID/USER of the share given options, so that the 
created directory would have the same UID as the to be mounted share!) 
-- meaning it might simply return ALL entries it could possibly return 
in the default format, which is the meaning of the wildcard, and the 
program (autofs daemon or module(?)) would be able to generate the 
appropriate directory entries based on that. So in that case you're 
probably going to be rid of the problem of the non-matching state of 
pre- and post-mount of directories.


>> a) get rid of the browse_mode = no, in the configuration file, for
>> static mounts
> 
> No, that has it's own set of problems which people need to be aware of 
> before
> choosing to use the "browse" option.

Not everyone.

I have like 5 mounts in this share. 5 shares in this mount. I have not 
noticed issues to begin with. Maybe there are issues like checking 
permissions on the directory prior to mounting it, and then being wrong 
about that once it is mounted. But still, that doesn't seem to happen. 
Actually, something funny is going on. 2 of the 8 shares that are 
'automatically' loaded are not accessible. "No such file or directory".

No, that's nothing but a permission error. Still I am allowed to see 
them but not use them. For a static file no issue; just delete them.

I don't really see what I need to be aware of prior to using browse?

If it is the most sensible "novice" use case, why not allow it by 
default? It things go mayhem people can turn it off, or you could even 
turn it off when the number of mounts in a map exceeds 20 or 30 or 50. 
It's an arbitrary number, but what if I am wrong about LDAP.

What about you mean it is turned off by default for LDAP, but you do not 
consider static files with that?

What about it does function for ldap. What about we just need a separate 
default for LDAP and its like, than we do for static?

Are you seriously considering static files, or do you mean LDAP, yp, 
hisplus, and hesoid?

For anyone using an actual database, I concur.

For static, I just disagree. That is the start case for anyone.





> 
>> b) say something about mounts not being created automatically in the 
>> man
>> page for auto.master, if nothing else. If you also do (a), this only
>> applies now to programmatic mounts.
> 
> auto.master(5) isn't the place for that, autofs(5) is better and, as I 
> say, make
> some suggestions of provide a patch.

autofs(8) is loaded before autofs(5). It's a good document, autofs(5), 
but most people may not even notice it. Personally I would probably 
choose to call them:

autofs.master(5) and autofs.map(5). But then, I also consider 
auto.master a very nondescript name.

In this way no one can ever get confused, so you might just rename 
autofs(5) to autofs.map(5).

Or even auto.map(5) if that is necessary, but I wouldn't do that.


> I'll have a look at doing this but beware, often distributions use 
> there own
> default master map which I have no control over.

I have no clue what mine does, this is Debian, and then Ubuntu, and then 
Kubuntu ;-) but it is just the Debian package still.

You don't have to follow my example or suggestion, maybe there is a 
better improvement than this, it was just an example, I guess. Or I 
could guess.

That was just a thing I was able to change without editing man files 
;-).

I will look into providing a patch, but I hope you can rename autofs(5) 
to autofs.map(5) before doing anything like that. I don't feel like 
improving a system I know myself haven't had access to, in that sense. I 
don't mean you have to do that straight away, but if that is a possible 
direction to go, or change to make, then I could supply a patch or 
anything based on the system that would result from that, seeing that 
autofs(5) is already pretty good in that sense.

>> I mean you could rewrite more documentation but this is the simplest I
>> could do right here right now.
>> 
>> I think that would clarify a lot for everyone but of course perhaps 
>> you
>> would want to rewrite more so the central documentation is also up to
>> date, but please see this as a more modest attempt for making it more
>> accessible to a new user.
> 
> Yes, adding the fact that mount point directories aren't pre created 
> for
> indirect maps somewhere in auto.master(5) and in a couple of places in 
> autofs(5)
> is a good idea. You are right it's something that can catch the 
> unaware.

That would also make the difference between direct and indirect more 
clear. (I still don't know exactly what is the entire difference).

That's also something I could change: how a direct map is explained in 
auto.master(5). But then, I didn't have access to autofs(5) to explain 
it to me better ;-).

Anyway, I think it is a good project, I didn't know autofs would be so 
good when it comes down to it.

It's usually documentation that puts you off ;-).

I often feel like I have to find the door in some invisible wall.

This time it was extreme because I couldn't for the life of me 
understand what a "key" would be in the sub-map file.

Regards, Bart.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
