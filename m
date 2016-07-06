From: Ian Kent <raven@themaw.net>
Subject: Re: documentation issues
Date: Wed, 06 Jul 2016 20:48:34 +0800
Message-ID: <1467809314.4580.172.camel@themaw.net>
References: <cec586e96030cbbc150886909bf34a45@dds.nl>
	 <1467766653.4580.46.camel@themaw.net>
	 <120efa5371880caa1f603fb7a4cded84@dds.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=PUapJk0Yq5R3JwrAmOHvfROpb3c=; b=QMBLvB
	0SuKFV300DNTemmjtkpmQCDegIH3RrzkQAq5MMcNhwjSrYHJI6624l4tg4LPRlqM
	CkeyYjz9O82YoyQhA992ePfI1iv3BB6ML++Wi4h/Fo/6Gmil7I9kSjsOdlPHF94Z
	UHr0/+FeQvbYH34sophAHZmcFW9N2vdmF3PgQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=PUapJk0Yq5R3Jwr
	AmOHvfROpb3c=; b=m4ncJkXr/JsBPtmW4ueP9uO4WOGmhHXIJWjrVXa9bPzCVN7
	47/8/qAi5a5W+sFS93TeYUyeXmVgyGrf/22WVQi/1CF6XkutvlJoF1zNXqsqaK0u
	NQtymaj7Y/mH8+eKypxbe6AtZsMc0wi8zME5ygmNGAUSMN3EckATMhNmqPtA=
In-Reply-To: <120efa5371880caa1f603fb7a4cded84@dds.nl>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Xen <list@xenhideout.nl>, Autofs <autofs@vger.kernel.org>

On Wed, 2016-07-06 at 06:47 +0200, Xen wrote:
> Ian Kent schreef op 06-07-2016 2:57:
> > On Tue, 2016-07-05 at 23:17 +0200, Xen wrote:
> > > Hi,
> > >=20
> > > a few things.
> > >=20
> > > A user attempting to use autofs for the first time will assume th=
at
> > > autofs will mount mount poins that already exist. Nowhere is it s=
tated
> > > that mount points will only get created when accessed (through a=20
> > > "direct
> > > path").
> >=20
> > Umm, "direct path" is an unfortunate choice here as you are talking=
=20
> > about autofs
> > indirect mount maps.
> >=20
> > Direct mount maps create a mount trigger for each map entry and so =
show=20
> > up as
> > mount points in the file system.
> >=20
> > There are reasons for it being this way.
>=20
> So you are berating me for choice of words ;-).

No, I'm trying to establish a common naming convention so both of us ca=
n avoid
possible confusion later.

There are a bunch of conventions used (at least I use) that have specif=
ic
meaning to me in relation to autofs. If I don't jump on those early the=
re is
often confusion about what I'm trying to say and there can be misunders=
tandings
even when I do. =20

>=20
> The only difference between direct and indirect seems to be that with=
=20
> direct the share is mounted "directly" on top of the specified mount=20
> point (actually, none is specified, it is mounted on the key returned=
=20
> from the map) and as a result it is not possible to have lazy=20
> initialization (unless you merged e.g. the root filesystem with an=20
> overlay filesystem) and so you are required to create this mountpoint=
,=20
> whereas with "indirect" you control the mount point itself and can=20
> choose whether to create the subdirectories or not (if you can acquir=
e a=20
> list). "Directly" seems to mean "directly on the filesystem" whereas=20
> "indirectly" seems to mean: inside our own little enclave.

Yes, that's about it.

But I don't understand your use of "lazy initialization".

Yes, autofs will create a mount point path for each entry in a direct m=
ount map.
And yes, there will be an autofs file system mounted on each path to ac=
t as a
trigger to cause the corresponding file system to be mounted during a k=
ernel
path walk (ie. when accessed).

So I don't quite understand what your concern is.
Sure, if you have hundreds or thousands of these there can be a perform=
ance
problem but that's not what you were trying to do I thought.

It sounded to me like these were a good fit for your case .....

>=20
> And always as a subdirectory of that. Not even technically necessary,=
=20
> you could even have a "indirect map" that triggered mounting I guess,=
=20
> don't know. I guess not.
>=20
>=20
>=20
> >=20
> > >=20
> > > Such a user (such as me) trying to use this thing (even with a=20
> > > tutorial
> > > on Ubuntu site) will be flabbergasted that nothing happens; he/sh=
e
> > > expects mount entries to appear, but nothing happens.
> > >=20
> > > This renders the "nobrowse" default dysfunctional for a desktop u=
ser,
> > > who expects to see something before going there. It only works fo=
r
> > > automated systems, really.
> >=20
> > Your assuming that autofs primary usage is targeted at the desktop.
> > It's often not the best use case for that.
> >=20
> > There are other more suitable automount alternatives for GUI deskto=
ps.
>=20
> Linus Torvalds says he developed Linux as a desktop OS. And how=20
> chagrined he is that it didn't succeed in just that. Well, now we kno=
w=20
> the reason for that ;-).
>=20
> I know there are probably alternatives; but they are mostly useless f=
or=20
> someone who wants to do it on his own. Desktop environments often do =
not=20
> even have mount operations on directories (even) when they are descri=
bed=20
> in fstab. There is no other way that I know of to automatically mount=
=20
> e.g. samba shares, unless you navigate directly to it (and then they =
end=20
> up in some weird location in the filesystem, if at all). There is=20
> usually also no "user based" fstab; where you can describe mounts=20
> specifically for your user, that are then mounted through e.g. fuse, =
or=20
> something else that can do suid. Perhaps you mean udisks or udisksd o=
r=20
> udisksctl but I'm not even sure that supports network-filesystems, th=
ey=20
> are certainly not shown in udisksctl status.
>=20
> Dolphin can not actually mount a share to some fixed location, the Ne=
mo=20
> I am using doesn't even succeed in browsing the network. For me there=
=20
> are only two solutions that I see, either fstab or autofs. Once you k=
now=20
> how to do it, running /etc/auto.smb <host> quickly returns a list of=20
> shares (if you've set the credentials file) that you can then edit to=
=20
> become a static map with the browse option.
>=20
> I do not see what is better suited currently to auto-mounting=20
> samba-shares. Anything that would work well, would work from both the=
=20
> shell and the GUI, in that the systems have to be linked, and ideally=
=20
> what the GUI does is stored in state files that work equally well fro=
m=20
> the shell. Any persistent mount would have to be stored somewhere on=20
> disk. Then the link would need to be automounted, OR mounted through=20
> e.g. libpam-mount. There is nothing wrong with mounting upon logon. A=
nd=20
> that allows for specific user-dependent stuff. (An automount dependin=
g=20
> on what user first accesses it, is problematic). (As for Samba). So=20
> perhaps logon-mounts are better suited (just restore the mount from t=
he=20
> previous session, in that sense) because the $UID problem is hard to=20
> solve for autofs, you must either duplicate all entries, and hardcore=
=20
> the UIDs you need, for every user, or I don't know what, prevent othe=
r=20
> users (including root) from accessing the share you need. You'd=20
> basically need map files in auto.master.d for every user, including a=
=20
> map file for each person to specify the shares, if you want browsable=
,=20
> or a modified version of auto.smb that mounts individual shares when=20
> accessed. (In the latter case you'd have no browse map).
>=20
> But this script doesn't know what it is being called on, so now you n=
eed=20
> a variable I guess for each of those .d/ files, so that their entries=
=20
> would be something like:
>=20
> /media/<user>/nas  /etc/auto-short.smb -Duser=3D<user> which would th=
en be=20
> used for the samba $UID.
>=20
> If there is a better way to do this, I don't know. I see no alternati=
ves=20
> other than libpam-mount and of course some GUI could do it, but then=20
> you'd really just have a form of duplicated functionality between aut=
ofs=20
> and it.
>=20
>=20
> > > - browse only works for static maps, and what person with a stati=
c map
> > > is going to run into performance issues when mount points are cre=
ated=20
> > > in
> > > advance? Can we please remove this from the default config? (turn=
ing=20
> > > it
> > > off).
> >=20
> > Well, quite a lot of current users actually.
> >=20
> > Consider what can happen with a few hundred or a few thousand entri=
es=20
> > in an
> > indirect map.
>=20
> Alright, but what indirect maps can cause browse tables to be shown?=20
> Only static maps, right? A programmatic map can only return a single=20
> entry. I have not looked into the other ones, but I suppose LDAP is m=
ore=20
> like a programmatic map than anything else.

Of course, yes, program maps can never know in advance what key may be =
passed to
them.

The problem is usually seen with user applications, cron jobs that scan
directories, GUI file management utilities etc.

It's has been quite a problem over time.

LDAP is a map source, like a file, or nis etc.

Maps stored in LDAP behave much the same as maps stored in files.

>=20
> So then consider that we only use a static map here. An actual file w=
ith=20
> thousands of entries? Of course it can happen. But what would be the=20
> point of that still (as opposed to LDAP or programmatic).

People do seem to like program maps but plenty of people use static or =
semi
-static maps, ie. a bunch of entries followed by the wildcard map key "=
*"
usually with some macro or "&" substution.

Similarly, what might match the wildcard map entry can't be known in ad=
vance.

>=20
>=20
> > Even though the browse option was added it has a specific set of=20
> > problems.
> >=20
> > First the kernel does not know if you are just listing a directory =
or=20
> > actually
> > need to mount something.
>=20
> Do you mean the directory containing the (indirect) entries (e.g. the=
=20
> managed directory) or one of those entries themselves?

It's hard enough for me to understand VFS path walking sufficiently wit=
hout
having to describe it too.

All I can say is there is a problem determining whether a call back to =
the
deamon is needed or not at the times the kernel module is called. That =
can
sometimes result in all entries in the autofs managed mount point direc=
tory
being mounted.

Another aspect of this problem is that the same system call may need to=
 have the
directory trigger a mount while not so at other times it's called and t=
here's no
way to tell what the usage is within in the kernel.

So sometimes people get caught because they want their stat(2) call to =
return
the mounted file system results but not to cause a mount at other times=
 when it
might lead to a mount storm.

These people are usually quite passionate as well insisting that it be =
fixed and
sometimes refuse to accept it is a problem.

Usuall all I can say to them is don't use the "browse" option.....

It is a difficult problem and I'm inevitably caught in the middle betwe=
en the
"browse" and "nobrowse" camps.

Not all cases of accessing such a directory will see this problem eithe=
r but
user space seems to have a habit of using system calls that don't trigg=
er a
mount together with others that do.

Causing the so called mount storm.

Having said that though, with a lot of work, I could probably do someth=
ing about
it.

TBH I've avoided it because it is difficult, perhaps in version 6.

It would require not pre-creating mount point directories and adding a =
readdir
implementation to the kernel to fill in the names (map keys) that aren'=
t already
mounted. But that means significantly more (in terms of quantity of)
communication between the daemon and the kernel module.

That means re-writing the user space <-> kernel space communications co=
mpletely
in an incompatible manner to what is used now, not to mention significa=
nt
changes to the user space code itself.

A big job really.

>=20
> > So at the moment, certain types of system call (the module can't kn=
ow=20
> > the exact
> > system call either) don't cause a call back to perform a mount but=20
> > often user
> > space will later make a system call that will cause a mount to occu=
r=20
> > anyway.
> >=20
> > That leads to sometimes seeing directories that are those of the au=
tofs=20
> > file
> > system not those of the mounted file system, so they have completel=
y=20
> > different
> > attributes to those after an automount has been done, a problem in=20
> > itself.
>=20
> Oh... such as ownership etc.
>=20
> The typical "I mount this, and now suddenly it is not root.root but=20
> xen.staff".
>=20
> > And, it can often lead to a mount storm, mounting everything in the=
=20
> > directory.
>=20
> But how can that happen? If I do; "for f in *; ls $f; done" sure.

It happens, from what I've seen, quite a bit.
Perhaps you would be surprised.

>=20
>=20
> >=20
> > OK for a few dozen mounts in a map but really bad for anything with=
=20
> > more than a
> > few hundred entries.
>=20
> After thinking a little I came up with what could perhaps be some=20
> default use case. You have terminals mounting home directories. On th=
e=20
> "terminal machine" you may have just a single user. Through LDAP you=20
> find the home directory. There is obviously no sense for all users in=
=20
> the LDAP system to now have precreated mount points. The only thing t=
hat=20
> could make sense is to have an "invisible" user directory that now ge=
ts=20
> mounted.

Yes, you would need to be using the default "nobrowse", or a limited se=
t of keys
with a wildcard entry.

>=20
> I can see no reason to have hundreds of mount points in a directory=20
> unless they cannot conform to a specific pattern. If they follow a=20
> pattern, it is likely that only a few of them need to be mounted at a=
ny=20
> time. In that case being able to browse it seems nonsensical. An=20
> aggregate of hundreds of different mounts at the same time seems very=
=20
> weird. Weird to have a diverse set of unique names to begin with. As =
if=20
> all of them were manually added in some way. If they aren't manually=20
> added, but automatically, then why have a static list? Would you not =
be=20
> better off putting that in a database? And if you'd have so many, we'=
d=20
> assume they could be different users, or different websites, etc. We=20
> also assume not all of them are going to be needed, just a subset. Bu=
t=20
> so now you have a system on which this list is statically created but=
=20
> dynamically updated. This list sits on the disk of the local system. =
But=20
> you're not querying a database (could be just as easy) that could als=
o=20
> store this list and return the entries one by one when needed. The=20
> static file is the database.
>=20
> Seems an improper use case but yeah. I don't know how you can have a=20
> static list that is huge while not choosing to use a database to mana=
ge=20
> it. Because a static map; now you need routines to update it, delete=20
> entries from it.

Yes, but network sources such as NIS and LDAP are treated much the same=
 as a
file map.

Checking if a file map has been updated since a key was last used is ea=
sier with
a file map and straight forward with a NIS map but can't sensibly be do=
ne for an
LDAP map.

>=20
> Maybe I'm missing something here.
>=20
>=20
> > Another reason for the default is that, because of this, historical=
ly=20
> > there was
> > no "browse" option and this maintains what is (should be) expected.
>=20
> Yeah I thought so, because of the comments near the timeout value.=20
> However that is a reason to never change anything ever. Someone=20
> mistakenly choosing "browse" will very quickly find out.

And wouldn't itself be sufficient but for the problems I'm attempting t=
o
describe above.

>=20
> If this person really has hundreds of items in his list, he will noti=
ce=20
> within a second that they are all visible. If this person really has=20
> hundreds to thousands of items, he or she may also be expected to kno=
w=20
> the ins and outs of the system, and to be aware of the browse option,=
 or=20
> be able to find out. This is not going to be a novice user.
>=20
> On the other hand, anyone new to the system will have modest goals.=20
> However those modest goals are frustrated and refuted because the sys=
tem=20
> is geared towards that professional that already knows everything, an=
d=20
> for whom adding nobrowse, or changing the config file, would probably=
 be=20
> a nobrainer. The new user however may be flabbergasted that it either=
=20
> does not work, or not the way she feels it should work (making a list=
,=20
> and then not seeing it in action).
>=20
>=20
>=20
> > > - browse being turned off by default combined with a complete lac=
k of
> > > mention that you need to access these "nonexistent" directory pat=
hs /
> > > components before you will be able to see them, turns autofs into=
 a
> > > complete mystery for someone who is not privy to the details yet.
> >=20
> > It's been a long time for me so I probably have forgotten what it's=
=20
> > like for
> > someone starting out.
> >=20
> > And so, how would I know where in the man pages to put that so it g=
ets=20
> > noticed
> > by new users, perhaps from your perspective, you could point out a =
few=20
> > key
> > places where it should be added, or better still send a patch.
>=20
> This happens a lot, it is no ones fault. I guess people who knows the=
=20
> ins and outs of something usually jump smack in the middle, and forge=
t=20
> to mention what the system is really like from the outside. A fish=20
> doesn't notice the water, we don't notice the air.
>=20
> We are too much immersed in it.
>=20
> I think there are 3-4 things I would explain.
>=20
> First the auto.master file on my system mentions man autofs as a plac=
e=20
> for seeing the format of the (sub)map files. However there is nothing=
 in=20
> there. So that part is missing, but in a sense the contents of auto.m=
isc=20
> is already somewhat sufficient for that, but still annoying that ther=
e=20
> is no man page.

That doesn't sound right, there might be a problem with your distributi=
on
package.

[raven@pluto autofs-dev.git]$ wc -l man/autofs.5
611 man/autofs.5
[raven@pluto autofs-dev.git]$ wc -l man/autofs.8.in=20
81 man/autofs.8.in

The first of these describes the Sun and amd map format map entries, no=
t a
particularly good job of it I admit, but that is where the changes you =
recommend
should go.

The second describes the service start and stop, etc.

>=20
> The second part is that it is often hard to understand what is meant =
by=20
> "key". In the master file, key means the mount point that supposedly=20
> already exists in the filesystem. In the sub-maps, key means the=20
> subdirectory but also the component of the path getting accessed by t=
he=20
> user. Both types of files are called map files, and both kind of keys=
=20
> are called keys. This is aggravated by the fact that there is no man=20
> page for the sub-maps, that I know of . Auto.smb then speaks of a key=
,=20
> but it doesn't say what it is. Of course after a while you realize it=
 is=20
> to be the host, but then you don't know how it knows about this host.=
=20
> Since at that point you don't realize that this is input from the=20
> filesystem (e.g. a stat operation) on "hidden directories" you are=20
> really clueless as to where this information is coming from ;-).

Sure, and that probably needs to be spelled out in autofs(5).
I know people do get confused by this distinction.

>=20
> You don't imagine that every freaking access of a directory or path=20
> component in the managed directory is going to result in network acce=
ss.
>=20
> You could do a "for f in `seq 1 10000000`; do vdir $f; done" and have=
=20
> fun.
>=20
> (Don't know if that would still be the case for "browse" maps).
>=20
> So this hidden directory, secret door thing is really the most confus=
ing=20
> of all.
>=20
> It's somewhat similar to something I might like to do, but still you=20
> don't really expect it ;-).
>=20
> So the 3-4 things are:
>=20
> create a man page or section for the format of the sub-maps

Already exists, needs work.
Lets call these mount maps (not the best but the convention used) as op=
posed to
the master map.

> indicate more clearly that programmatic maps in principle return a=20
> single entry

Maybe but isn't this in autofs(5) already close:

   Executable Maps
       A map can be marked as executable. A program map will be called
       with the key as an argument. It may return no lines of output
       if there's an error, or one or more lines containing a map entry
       (with \ quoting line breaks). The map entry corresponds to what
       would normally follow a map key.

> indicate that programmatic maps currently require access of a path=20
> component and that this path component (user action) is the key to th=
e=20
> script.

But that is the case for all maps:

Isn't this near the top of autofs(5) sufficient:

       key [-options] location

       key
              For indirect mounts this is the part of the path
              name between the mount point and the path into
              the filesystem when it is mounted. Usually you
              can think about the key as a sub-directory name
              below the autofs managed mount point.

              For direct mounts this is the full path of each
              mount point. This map is always associated with
              the /- mount point in the master map.


> indicate that this is true for "no browse" on "static maps" as well, =
and=20
> that directories are only created when they are accessed.

That seems to be missing from the man page.

> And that no-browse is the configured default.

Not sure about that either.

This (from auto.master(5)) says that I have made "browse" the internal =
program
default way back when version 5 was first developed but I install a
configuration that turns it off because of (because of the above proble=
ms, which
are not spelled out in the man page):

     [no]browse
            This is an autofs specific option that is a pseudo mount
            option and so is given without a leading dash. Use of the
            browse option pre-creates mount point directories for
            indirect mount maps so the map keys can be seen in a
            directory listing without being mounted. Use of this
            option can cause  performance problem if the indirect
            map is large so it should be used with caution. The
            internal program default is to enable browse mode for
            indirect mounts but the default installed configuration
            overrides this by setting BROWSE_MODE to "no" because
            of the potential performance problem.

Don't forget that distributions can, and often do, install their own ve=
rsion of
auto.master and possibly the autofs configuration.

And looking at the man pages shows that I have missed changing some of =
the
configuration option names from the recent configuration file changes, =
something
else that needs to be done.

>=20
> Currently the documentation for the master map and for (indirect)=20
> sub-maps is really in auto.master and auto.misc.
>=20
> Reading config files is usually a lot more pleasant than man pages ;-=
)=20
> so that's not such a huge problem, but you can't learn anything from =
a=20
> very limited set of examples either ;-).
>=20
> For instance: direct map won't work if not prefixed with /, but will=20
> also not give error if not. Indirect map (I think) won't work if=20
> prefixed with /, but will also not give error if not.
>=20
> I could say more but my thumb is hurting (infected) so I gotta quit=20
> this.
>=20
> I don't mind writing documentation. But I'm not familiar yet with man=
=20
> pages and their technical structure and all.
>=20
> I'll have to see. Thank you for the interest in any case :).
>=20
>=20
> > >=20
> > >=20
> > > Further I would say that on a desktop OS, the most likely use cas=
e is
> > > going to be this:
> > >=20
> > > - have several shares in your home network
> > > - want to access them through a GUI
> > > - prefer automounting since mounting at boot can be problematic
> > > - need to see them before you can access them in a GUI
> > > - only alternative is "bookmarks" or "places" that work regardles=
s of
> > > the things not being visible/listed in the directory.
> >=20
> > Either use a different automounting mechanism or use a direct mount=
=20
> > map.
> >=20
> > That would satisfy all these needs, all be it with the map entries=20
> > always being
> > mounted on access.
> >=20
> > The limitation of these is you can't have a direct map path that is=
=20
> > within
> > another automounted path, if you need to do that you need to use a =
more
> > complicated setup.
>=20
> I think that limitation indicates why using relative paths is so much=
=20
> more pleasant. A map file using relative files can be "moved around".=
 A=20
> map file using absolute paths cannot.
>=20
> Could you not make a direct map out of the key of the master file, an=
d=20
> the keys of the sub-maps?

Can't really do that.

The closest thing to that would be multi-mount map entries, again from
autofs(5):

   Multiple Mounts
       A multi-mount map can be used to name multiple filesystems
       to mount. It takes the form:

       key [ -options ] \
           [[/] location \
          [/relative-mount-point [ -options ] location...]...

       This may extend over multiple lines, quoting the line-breaks wit=
h
       `\=C2=B4.  If present, the per-mountpoint mount-options are appe=
nded
       to the default mount-options. This behaviour may be overridden
       by the append_options configuration setting.


> If there is really a need for huge static map files (I haven't studie=
d=20
> LDAP) in principle all you need is a syntax to differentiate between =
the=20
> two, right.
>=20
> /-         ( /this/is/my/abs/path )
>=20
> or
>=20
> /this/is/my/abs      ( -/path )
>=20
> could be identical

Not really, the master map key "/-" is required to specify the direct m=
ount maps
that are to be used, anything else is an indirect mount, and "/-" is on=
ly valid
within the master map (although I can't remember if I explicitly check =
for it
within mount maps).

>=20
> normally ( /bla/bla ) indicates an absolute path and can only be used=
 in=20
> a direct map, from what I've seen. You *could* cause it to turn this=20
> "indirect map" into a direct one.
>=20
> ie. ( bla/bla ) =3D=3D indirect
>      ( /bla/bla ) =3D=3D direct.

In the Sun map format maps indirect mount map keys are a single path co=
mponent
only.

The situation is different if using amd format maps but I could work ou=
t how
direct mount maps could be usefully used so that mount type has not bee=
n
implemented. Even on Solaris where they are supposed to be fully suppor=
ted I
could make sense of them.

>=20
> A direct map is always a static file right? But then it doesn't matte=
r=20
> what part of the path is specified in what file.
>=20
> Or
>=20
>      ( bla/bla ) =3D=3D indirect
>      ( -/bla/bla ) =3D=3D direct
>=20
> So you get:
>=20
> /start/of/the  (-/path )
>=20
> or
>=20
> /start/of/the/-  ( path )
>=20
> Then any path in the master file ending with /- would be a direct pat=
h.
>=20
> And would cause the (static) map file to be treated as direct.

Nope, that is unlikely to work and would lead to a lot of problems.

One example might be with:

/start/of/the/-/path

people will ask where have the directories below /start/of/the/ gone an=
d the
answer will be they have been covered by the autofs file system mount.

Next it would be but I should be able to see these, surely that's easy =
to fix.

At hat point I would probably leave the conversation.

In any case a similar thing, but more explicit and I think easier to fo=
llow and
maintain are the autofs multi-mount map entries, what I think you calle=
d
relative path above.

It isn't clear but that syntax should function within both direct and i=
ndirect
mount maps.

The problem with all this is that substitution cannot be used in the ke=
y.

The reason for that is same as why the amd regex key matching has not b=
een
implemented.

A linear map scan would be needed for every lookup in order to match wh=
at has
been sent to us from the kernel. And as much as you might feel that wou=
ldn't be
a problem because maps are generally small I can assure you it would ma=
ke like
really unpleasant for me!

>=20
>=20
>=20
> >=20
> > >=20
> > > Then I will also say,
> > >=20
> > > that there is no documentation on the format of the map files oth=
er=20
> > > than
> > > auto.master. The documentation for map files is this:
> >=20
> > That's not quite right.
> >=20
> > Man page autofs(5) has a bit of information on both the Sun and amd=
=20
> > format maps.
>=20
> Oh I am sorry. I think many users are not versed in the numbers for t=
he=20
> man pages. I for one do not notice the difference and I almost never =
use=20
> one of those numbers. Sorry, I seriously missed that.
>=20
> I only noticed just now because autofs(8) references autofs(5), and I=
'm=20
> like ....huh?

Yeah, that's what we have ....

>=20
> Okay, allright. Missed that.
>=20
> Seriously bad system if you ask me, but okay.
>=20
> So I guess you can have direct maps with LDAP etc. too.
>=20
> I guess the wildcard also solves the many-user problem.
>=20
> Well, but only for the sub-map. You couldn't get autofs to manage=20
> /media, so it needs to be /media/user/<aggregate> in which user can't=
=20
> suddenly be a wildcard unless you use a direct map. You could expand=20
> that to include the master file though:
>=20
> /media/*/nas    /etc/nas-shares.map

Can't do that, each /media/*/nas needs to be mounted at program start s=
o that
automounts can be done?

Chicken before the egg problem there.

You might be able to achieve something sensible with a wildcard and off=
set
mounts (the relative paths above) and macro and & substution.

It is a bit difficult though.

>=20
> And then in /etc/nas-shares.map:
>=20
> share1   -fstype=3Dxxx,uid=3D&   ://nas/share1
> share2   -fstype=3Dxxx,uid=3D&   ://nas/share2
>=20
> I can't see whether LDAP supports browse, I assume it must, since it=20
> supports direct.

Yep, same as file maps except remote maps cannot use plus map inclusion=
, like
the
+auto.master
you might see in default installed master maps.

>=20
>=20
>=20
>=20
> > By definition a program map can't know what keys may be passed to i=
t.
> > And, yes, even autofs(5) doesn't say explicitly that a program map=20
> > doesn't know
> > what keys may be passed to it, perhaps that should be ammended.
>=20
> In principle even a program map could read all of the available keys=20
> from whatever database it consults, and return all of them; or return=
=20
> something only (as it does now, perhaps) when a given key matches (is=
=20
> found).

I've thought of that too.

But I've resisted because I'm concerned about confusing existing progra=
m maps
people have in unpleasant ways.

But that suggestion has been made before and .....

>=20
> If you wanted that you would need the program script to e.g. support =
a=20
> wildcard as parameter. Meaning, all scripts must then check for "*" t=
o=20
> be passed to it, in order to return the full list that they can acqui=
re=20
> (if even possible) or at least return an error of some kind to say th=
at=20
> they don't support it.
>=20
> You'd need a parameter for it, and any script would need to be aware =
of=20
> that parameter.
>=20
> That's either gonna be a wildcard or something given on $2, in that c=
ase=20
> every existing script would already be compatible with it, since it=20
> simply disregards $2.

That's not a bad thought, but what would $1 be so that older scripts wo=
uldn't
choke on it.

>=20
> So, for instance, if $2 is "browse" the script may choose to return a=
=20
> browse map, or list of shares, with whatever options are available (i=
t=20
> could even return the UID/USER of the share given options, so that th=
e=20
> created directory would have the same UID as the to be mounted share!=
)=20
> -- meaning it might simply return ALL entries it could possibly retur=
n=20
> in the default format, which is the meaning of the wildcard, and the=20
> program (autofs daemon or module(?)) would be able to generate the=20
> appropriate directory entries based on that. So in that case you're=20
> probably going to be rid of the problem of the non-matching state of=20
> pre- and post-mount of directories.

which pretty much defeats the only possible solution I can think of for=
 "browse"
option mounts ...

>=20
>=20
> > > a) get rid of the browse_mode =3D no, in the configuration file, =
for
> > > static mounts
> >=20
> > No, that has it's own set of problems which people need to be aware=
 of=20
> > before
> > choosing to use the "browse" option.
>=20
> Not everyone.
>=20
> I have like 5 mounts in this share. 5 shares in this mount. I have no=
t=20
> noticed issues to begin with. Maybe there are issues like checking=20
> permissions on the directory prior to mounting it, and then being wro=
ng=20
> about that once it is mounted. But still, that doesn't seem to happen=
=2E=20
> Actually, something funny is going on. 2 of the 8 shares that are=20
> 'automatically' loaded are not accessible. "No such file or directory=
".
>=20
> No, that's nothing but a permission error. Still I am allowed to see=20
> them but not use them. For a static file no issue; just delete them.
>=20
> I don't really see what I need to be aware of prior to using browse?
>=20
> If it is the most sensible "novice" use case, why not allow it by=20
> default? It things go mayhem people can turn it off, or you could eve=
n=20
> turn it off when the number of mounts in a map exceeds 20 or 30 or 50=
=2E=20
> It's an arbitrary number, but what if I am wrong about LDAP.
>=20
> What about you mean it is turned off by default for LDAP, but you do =
not=20
> consider static files with that?
>=20
> What about it does function for ldap. What about we just need a separ=
ate=20
> default for LDAP and its like, than we do for static?
>=20
> Are you seriously considering static files, or do you mean LDAP, yp,=20
> hisplus, and hesoid?
>=20
> For anyone using an actual database, I concur.
>=20
> For static, I just disagree. That is the start case for anyone.

Like I said, I wanted to have the default as "browse" but got hit with =
too many
complaints and was only willing to change the package installed default
configuration to satisfy them.

I'm not going to try that again.

>=20
>=20
>=20
> >=20
> > > b) say something about mounts not being created automatically in =
the=20
> > > man
> > > page for auto.master, if nothing else. If you also do (a), this o=
nly
> > > applies now to programmatic mounts.
> >=20
> > auto.master(5) isn't the place for that, autofs(5) is better and, a=
s I=20
> > say, make
> > some suggestions of provide a patch.
>=20
> autofs(8) is loaded before autofs(5). It's a good document, autofs(5)=
,=20
> but most people may not even notice it. Personally I would probably=20
> choose to call them:
>=20
> autofs.master(5) and autofs.map(5). But then, I also consider=20
> auto.master a very nondescript name.
>=20
> In this way no one can ever get confused, so you might just rename=20
> autofs(5) to autofs.map(5).

Yeah maybe ...

>=20
> Or even auto.map(5) if that is necessary, but I wouldn't do that.
>=20
>=20
> > I'll have a look at doing this but beware, often distributions use=20
> > there own
> > default master map which I have no control over.
>=20
> I have no clue what mine does, this is Debian, and then Ubuntu, and t=
hen=20
> Kubuntu ;-) but it is just the Debian package still.
>=20
> You don't have to follow my example or suggestion, maybe there is a=20
> better improvement than this, it was just an example, I guess. Or I=20
> could guess.
>=20
> That was just a thing I was able to change without editing man files=20
> ;-).
>=20
> I will look into providing a patch, but I hope you can rename autofs(=
5)=20
> to autofs.map(5) before doing anything like that. I don't feel like=20
> improving a system I know myself haven't had access to, in that sense=
=2E I=20
> don't mean you have to do that straight away, but if that is a possib=
le=20
> direction to go, or change to make, then I could supply a patch or=20
> anything based on the system that would result from that, seeing that=
=20
> autofs(5) is already pretty good in that sense.

At some point I'll need to return to this and make a list.
Unfortunately that time isn't now.

>=20
> > > I mean you could rewrite more documentation but this is the simpl=
est I
> > > could do right here right now.
> > >=20
> > > I think that would clarify a lot for everyone but of course perha=
ps=20
> > > you
> > > would want to rewrite more so the central documentation is also u=
p to
> > > date, but please see this as a more modest attempt for making it =
more
> > > accessible to a new user.
> >=20
> > Yes, adding the fact that mount point directories aren't pre create=
d=20
> > for
> > indirect maps somewhere in auto.master(5) and in a couple of places=
 in=20
> > autofs(5)
> > is a good idea. You are right it's something that can catch the=20
> > unaware.
>=20
> That would also make the difference between direct and indirect more=20
> clear. (I still don't know exactly what is the entire difference).
>=20
> That's also something I could change: how a direct map is explained i=
n=20
> auto.master(5). But then, I didn't have access to autofs(5) to explai=
n=20
> it to me better ;-).
>=20
> Anyway, I think it is a good project, I didn't know autofs would be s=
o=20
> good when it comes down to it.
>=20
> It's usually documentation that puts you off ;-).
>=20
> I often feel like I have to find the door in some invisible wall.
>=20
> This time it was extreme because I couldn't for the life of me=20
> understand what a "key" would be in the sub-map file.
>=20
> Regards, Bart.
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
