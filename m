From: Ian Kent <raven@themaw.net>
Subject: Re: documentation issues
Date: Mon, 11 Jul 2016 22:09:50 +0800
Message-ID: <1468246190.3102.121.camel@themaw.net>
References: <cec586e96030cbbc150886909bf34a45@dds.nl>
	 <1467766653.4580.46.camel@themaw.net>
	 <120efa5371880caa1f603fb7a4cded84@dds.nl>
	 <1467809314.4580.172.camel@themaw.net>
	 <9c9a4677493eb868dc68f02d8e5b10c7@dds.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=j4HHzy4RZNVh8jvgYcLaIictREc=; b=ddPS87
	W9bDecaZwzNAhSn2LZC4IWwOFM8dPQfgvKHqZxWURcfHqrBUlCJ0ZTC3IGOlZCIY
	xHJSyl0+Ez4O0UKmShTWNGsWujlbA0YnHIB0qaxxuiDZjZQ9jyfT26iEMsc5Jtpc
	ltBmYBiUoC6SB8CyIGiLzIqu6Ibv6YVY+5pbY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=j4HHzy4RZNVh8jv
	gYcLaIictREc=; b=BEi1f2wYSzT0AjYqvJs5s+DeYsdwCLK+bCMf3rIuDoBQVO8
	IY1Q1CMi2y6WvvgBY9dW55syQinkEEbCXu03f9JBKvcdt422oMXTRScwoEYTNnzJ
	V63MtBSdrzA71WhflIPeLT+JqNokI63328lVSDZ+il8hC+TSXXo6qc3URh1Q=
In-Reply-To: <9c9a4677493eb868dc68f02d8e5b10c7@dds.nl>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Xen <list@xenhideout.nl>, Autofs <autofs@vger.kernel.org>

On Sun, 2016-07-10 at 19:07 +0200, Xen wrote:
> Ian Kent schreef op 06-07-2016 14:48:
>=20
> > But I don't understand your use of "lazy initialization".
>=20
> I meant creating the mount point only when it was accessed.
>=20
> > So I don't quite understand what your concern is.
> > Sure, if you have hundreds or thousands of these there can be a=20
> > performance
> > problem but that's not what you were trying to do I thought.
>=20
> I'm not sure either at this point but I'm too hungry to read back on=20
> what I had written before :p.
>=20
> > Of course, yes, program maps can never know in advance what key may=
 be=20
> > passed to
> > them.
> >=20
> > The problem is usually seen with user applications, cron jobs that =
scan
> > directories, GUI file management utilities etc.
> >=20
> > It's has been quite a problem over time.
>=20
> Yes that is my concern. I do not like the idea of invisible access=20
> points at all, unless I was doing it for security, but in that sense =
you=20
> can't really hide anything in a Linux system. Invisible mount points=20
> only make sense when you have LOTS of them and you only need few at a=
=20
> time.

And that is a fairly common case.
Don't forget the implications of scanning these directories during expi=
re.
It doesn't take much to increase the overhead of that.

Like I said before, the amount of work to do this is huge.

What is needed is a re-write of the user space <-> kernel space communi=
cation
essentially to add readdir functionality.

So that listing a directory would show the possible map mount points wi=
thout the
need to create the mount point directories.

That is still open to excessive unnecessary mounting but not nearly as =
much as
pre-created directories.

>=20
>=20
> > LDAP is a map source, like a file, or nis etc.
> >=20
> > Maps stored in LDAP behave much the same as maps stored in files.
>=20
> Right so you can browse them if you want.

Yep.

>=20
>=20
> >=20
> > >=20
> > > So then consider that we only use a static map here. An actual fi=
le=20
> > > with
> > > thousands of entries? Of course it can happen. But what would be =
the
> > > point of that still (as opposed to LDAP or programmatic).
> >=20
> > People do seem to like program maps but plenty of people use static=
 or=20
> > semi
> > -static maps, ie. a bunch of entries followed by the wildcard map k=
ey=20
> > "*"
> > usually with some macro or "&" substution.
> >=20
> > Similarly, what might match the wildcard map entry can't be known i=
n=20
> > advance.
>=20
> Right. That makes it programmatic; the (server) response will determi=
ne=20
> if anything was actually there. On the other hand a wildcard (in a=20
> direct map at least) may determine existing (or match existing)=20
> filesystem components that you could read in advance. And you need to=
,=20
> in a direct map. But direct maps are mounted anyway (or the mountpoin=
t=20
> is created, I mean). So it currently only applies to indirect maps wh=
ere=20
> the wildcard is the final component, and it then behaves like a=20
> programmatic thing where it only actually gets mounted (and created) =
if=20
> e.g. the server reponds with a share.

A matter of terminology really, I don't see them as programmatic myself=
=2E

But also direct mount maps cannot contain a wildcard entry.

They must be distinct and known at the time the map is read because eac=
h entry
is used to mount an autofs file system to act as a trigger for the actu=
al mount.

That's why they can't be nested in any way since that could cover other=
 direct
mounts below the nesting point when a mount is triggered.

>=20
>=20
> > It's hard enough for me to understand VFS path walking sufficiently=
=20
> > without
> > having to describe it too.
>=20
> I don't know. I studied it in some detail, I just don't understand th=
e=20
> RCU algorithm. At least, I have studied path_lookupat and the entire=20
> procedure leading up to lookup_fast and lookup_slow. I'd have to chec=
k=20
> my printouts to say more. But let's just say I'm aware of any=20
> (recursive) operation involving symlinks, where intermediate symlinks=
=20
> get expanded before the original path is being continued, etc. I am a=
lso=20
> aware of the presence of autofs code, particularly in the function th=
at=20
> specifies one or two other mount things.
>=20
> I believe that is called by lookup_slow....

Yeah, while there are no locks held when following a mount point (where
automounting might be done) during the path walk you can't do most of t=
he
remainder of the path walking code lockless or rather without taking re=
ferences
to the struct path, you might see the terms ref-walk and I think rcu-wa=
lk in the
code, that's the main difference between lookup_slow() and lookup_fast(=
) IIRC.

The name rcu-walk I think is possibly not the best naming.

It implies a lockless and reference-less path walk which is much faster=
 for
certain work loads. But if the underlying structures are in danger of c=
hanging
in ways that can't be properly handled by the read-copy-update (RCU) me=
chanism
the path walk needs to revert to a ref-count(ed) walk which also allows=
 locking.

That really just means taking a reference to the struct path (and the a=
bility to
take a lock on certain other structures when needed) so it can't go awa=
y from
under you while you are using it, starting over when you hit such a cas=
e.

>=20
>=20
>=20
> > All I can say is there is a problem determining whether a call back=
 to=20
> > the
> > deamon is needed or not at the times the kernel module is called. T=
hat=20
> > can
> > sometimes result in all entries in the autofs managed mount point=20
> > directory
> > being mounted.
>=20
> So the mount point is accessed but the module doesn't know if anythin=
g=20
> really needs to happen at that point. And stat operations or anything=
=20
> else all use the same path lookup. Of course I don't know what happen=
s=20
> pre-mount and post-mount to the directory itself. If post-mount the=20
> directory is really on another filesystem, the "mnt" value will chang=
e.=20
> And it will return another dentry for that other mount. I remember=20
> "path" being mnt+dentry.

Actually the main automounting function of the module will be called ba=
ck with
essentially the path component only.

Most of the logic to decide if a mount should be done has now been take=
n into
the VFS mount following logic.

And all it has are the lookup flags, like LOOKUP_DIRECTORY, LOOKUP_CREA=
TE, etc.

Essentially all that's known is the class of lookup, directory, create,=
 continue
or other, which is a loose division of the related system calls, where =
continue
means an intermediate path component.

The directory, create and continue classes trigger automounts, other cl=
asses
usually don't (which are generally stat type system calls et. al.).

>=20
> >=20
> > Another aspect of this problem is that the same system call may nee=
d to=20
> > have the
> > directory trigger a mount while not so at other times it's called a=
nd=20
> > there's no
> > way to tell what the usage is within in the kernel.
>=20
> So you are getting called by lookup_slow or something of the kind nea=
r=20
> it, but you're not sure why. But these lookups are being done for eac=
h=20
> individual path componenent. However a "cd" to the directory should=20
> mount it, but a mere "stat" may not. Is that the case? Seems odd that=
 it=20
> would be difficult, but I believe you on your word.
>=20
> Maybe "cd" shouldn't mount it until the contents is accessed, but I=20
> don't know.

Yeah, but "cd" isn't a system call it's a bunch of code that makes syst=
em calls
which must result in a mount because this directory is to be set in the=
 VFS as a
process working directory, it must be fully resolved at that point.

>=20
>=20
> >=20
> > So sometimes people get caught because they want their stat(2) call=
 to=20
> > return
> > the mounted file system results but not to cause a mount at other t=
imes=20
> > when it
> > might lead to a mount storm.
>=20
> Hmm. It seems like the first desire is a problem. At least, I don't k=
now=20
> how directory lookup is done. I don't know if this information is the=
=20
> result of a stat call or something else. I do remember seeing code fo=
r=20
> dentry-moving but it was confusing.
>=20
> For sure you want "ls /directory/" to return the mounted contents. Bu=
t=20
> I'm not sure if its possible for your module to differentiate. Ls -d=20
> "/directory/" should perhaps not cause mounting. I can see quickly=20
> though that "ls" causes an "open" call but "ls -d" does not.
>=20
> But then, "open" will not access any path components beyond the=20
> directory itself. So if your module is only called by path_lookup it =
is=20
> going to be impossible to know what for.
>=20
> Particularly if an "ls" does not actually access path componenets=20
> (beyond the directory itself) there would be no way to know what is=20
> being asked.

There's one other thing to be aware of in all this.
Adding a "/" to the end of a path tells the kernel path walk this must =
resolve
to a directory so the LOOKUP_DIRECTORY flag will be set and automountin=
g will
occur in that case.

That is about all the control available in user space and TBH not a big=
 change
to code if you really need stat to return the actual mounted file syste=
m
information, given that non-directories can't be mount points and so ar=
en't a
problem.

>=20
>=20
> > Usuall all I can say to them is don't use the "browse" option.....
>=20
> :).
>=20
>=20
> > It is a difficult problem and I'm inevitably caught in the middle=20
> > between the
> > "browse" and "nobrowse" camps.
>=20
> You appear to be very conscientious about it.
>=20
>=20
> > Not all cases of accessing such a directory will see this problem=20
> > either but
> > user space seems to have a habit of using system calls that don't=20
> > trigger a
> > mount together with others that do.
>=20
> such as that "ls" vs "ls -d"?

Can't remember the difference between these two codewise but, for examp=
le, doing
a stat(2) call then an opendir(3) and not being able to handle the fact=
 that
this changes from a directory that doesn't have a mount on it to one th=
at does
between the two system calls.

Which has caused find(1) to get very confused (in the somewhat distant =
past now
though), ;)

>=20
>=20
> > Causing the so called mount storm.
>=20
> Still seems odd but I believe you, but. I guess what it could mean is=
=20
> "ls" not only trying to list every share (browse) but also to perform=
=20
> calls on those shares (path componenents retrieved) that might requir=
e=20
> additional information. For example, if I am not content just knowing=
=20
> the shares, but also want to know the number of files in them.... whi=
ch=20
> definitely some programs or user agents would do. Then I'm in trouble=
=20
> because this requires mounting. Then, if that is the case, a simple
>=20
> "list /nas/" might result in the subfolders (/nas/media, /nas/backup,=
=20
> etc.) to also be queried and you have what you call a mount-storm.
>=20
> But this is the result of user space convention and behaviour. Surely=
=20
> people cannot request browse while at the same time wanting to deny=20
> actions on the returned results when these actions stem completely fr=
om=20
> userspace?
>=20
> If some user agent or GUI is trying to list the number of files in ea=
ch=20
> directory (which at this point means a share) then that's not somethi=
ng=20
> autofs could ever deal with. And I don't think it is a problem autofs=
=20
> needs to solve.
>=20
> If I am at all correct about this and I see what you mean right now,=20
> this "GUI" behaviour would then simply be incompatible with unmounted=
=20
> folders *that-might-need-to-get-mounted-but-not-always* and this GUI=20
> would need to be aware to not do that thing.

That's about right, and isn't a problem until someone with a largish ma=
p set for
browse decides to access it with a GUI, then the complains start, ;)

But it isn't an unreasonable expectation it's just problematic to make =
it work
the way we would like.

>=20
>=20
>=20
>=20
> >=20
> > Having said that though, with a lot of work, I could probably do=20
> > something about
> > it.
> >=20
> > TBH I've avoided it because it is difficult, perhaps in version 6.
> >=20
> > It would require not pre-creating mount point directories and addin=
g a=20
> > readdir
> > implementation to the kernel to fill in the names (map keys) that=20
> > aren't already
> > mounted. But that means significantly more (in terms of quantity of=
)
> > communication between the daemon and the kernel module.
> >=20
> > That means re-writing the user space <-> kernel space communication=
s=20
> > completely
> > in an incompatible manner to what is used now, not to mention=20
> > significant
> > changes to the user space code itself.
> >=20
> > A big job really.
>=20
> And not a big joy perhaps.
>=20
> So basically you are going to not precreate, but still hijack kernel=20
> calls to return the listings for the directories that do not yet exis=
t=20
> (the listing of those directories).

Yes, similar to what the NFS READDIR or READDIR_PLUS RPC methods do.
It's not a new idea by any stretch.

>=20
> Which means those directories could be shown, but not opened, or=20
> something of the kind. Then, the user agent .. well I don't know what=
=20
> difference it makes actually if the mount storm is the result of=20
> userspace calls that directly cause it. So I guess I'm mistaken here =
and=20
> the issue is even more complex.... :(.
>=20
> I don't know how a readdir on the "top" directory could /directly/=20
> causes a mountstorm on the listed entries. But then, I don't know muc=
h=20
> ;-).

It's usually not actually the readdir that causes the problems it's ass=
ociated
calls done by code surrounding the readdir that generally it.

I mean if stat(2) was to cause a mount to occur then there would be a l=
ot of
mount storms reading directories.

Implementing an in kernel readdir won't get rid of the possibility of e=
verything
in a directory being mounted on access but it would go a fair way to av=
oiding
cases where you didn't want or need everything mounted upon listing a d=
irectory.

Just how effect it would be has been something I've thought about many =
times,
still not sure of the actual answer.

>=20
>=20
> > It happens, from what I've seen, quite a bit.
> > Perhaps you would be surprised.
>=20
> Illuminate me :P. What is the most common cause of it?

GUI applications.
Cron jobs scanning directories and causing so many mounts they cripple =
the
system.

The point of the statement was more about number of people that happen =
to have
large maps than anything.

> > Yes, but network sources such as NIS and LDAP are treated much the =
same=20
> > as a
> > file map.
>=20
> Yes, I didn't realize at the start. I have always found LDAP to be a=20
> rather incomprehensible thing to work with. Without hands-on experien=
ce=20
> it is hard to get a good grasp of how it works. Or even how to organi=
se=20
> it (if you do create one) as there seem to be standards for everythin=
g.

You think just checking it out looks incomprehensible, the autofs LDAP =
lookup
module code is very verbose (incomprehensible really) and quite hard to=
 work
with.

I'd be much happier if LDAP never existed.

>=20
>=20
> > Checking if a file map has been updated since a key was last used i=
s=20
> > easier with
> > a file map and straight forward with a NIS map but can't sensibly b=
e=20
> > done for an
> > LDAP map.
>=20
> Right.
>=20
> >=20
> > >=20
> > > Maybe I'm missing something here.
> > >=20
> > >=20
> > > > Another reason for the default is that, because of this, histor=
ically
> > > > there was
> > > > no "browse" option and this maintains what is (should be) expec=
ted.
> > >=20
> > > Yeah I thought so, because of the comments near the timeout value=
=2E
> > > However that is a reason to never change anything ever. Someone
> > > mistakenly choosing "browse" will very quickly find out.
> >=20
> > And wouldn't itself be sufficient but for the problems I'm attempti=
ng=20
> > to
> > describe above.
>=20
> You mean the mountstorm problems are reasons to keep the default at=20
> no-browse?
>=20
> It still seems at this point that this is only relevant for LDAP/NIS=20
> entries.
>=20
>=20
>=20
> > > First the auto.master file on my system mentions man autofs as a =
place
> > > for seeing the format of the (sub)map files. However there is not=
hing=20
> > > in
> > > there. So that part is missing, but in a sense the contents of=20
> > > auto.misc
> > > is already somewhat sufficient for that, but still annoying that =
there
> > > is no man page.
> >=20
> > That doesn't sound right, there might be a problem with your=20
> > distribution
> > package.
>=20
> No, as I say later this is incomprehension on my part ;-). Or merely =
the=20
> fact that needing to use "number" for accessing "sections" of the=20
> "manual" is so rare (if you are not a developer accessing library=20
> functions and/or kernel functions) that a regular user will almost NE=
VER=20
> use a section number in daily operation.

LOL, I got that later, yes.

>=20
> Most configuration files are called "openvpn.conf" or something of th=
e=20
> kind, and hence their manual page is also called that, and you don't=20
> need to do "man 5 openvpn.conf", because "man openvpn.conf" is=20
> sufficient.
>=20
> Using numbers would be superfluous in 99% of cases, or even more than=
=20
> that. As opposed to perhaps requesting help on function calls, such a=
s=20
> mount() as opposed to /bin/mount.
>=20
> So as a developer you may be used to it. But a regular user is not.=20
> Anyone who does not do C programming, is not.

Yeah, maybe, but you still need to account for the case when there are =
two
things of the same name, one configuration oriented and one system orie=
ntated,
one belonging in section 5 and one belonging section 8.

In the autofs case autofs.conf(5) has it's own man page for configurati=
on and
autofs(8) for startup information and autofs(5) for mount map informati=
on.

Actually seems mostly sensible to me, since while mount maps are config=
uration
in a sense they don't quite fit with the actual application configurati=
on of
autofs.conf(5).

>=20
> So, my mistake, I guess.
>=20
> > >=20
> > > You don't imagine that every freaking access of a directory or pa=
th
> > > component in the managed directory is going to result in network=20
> > > access.
> > >=20
> > > You could do a "for f in `seq 1 10000000`; do vdir $f; done" and =
have
> > > fun.
> > >=20
> > > (Don't know if that would still be the case for "browse" maps).
> > >=20
> > > So this hidden directory, secret door thing is really the most=20
> > > confusing
> > > of all.
> > >=20
> > > It's somewhat similar to something I might like to do, but still =
you
> > > don't really expect it ;-).
> > >=20
> > > So the 3-4 things are:
> > >=20
> > > create a man page or section for the format of the sub-maps
> >=20
> > Already exists, needs work.
> > Lets call these mount maps (not the best but the convention used) a=
s=20
> > opposed to
> > the master map.
>=20
> Alright. Still confusing though.
>=20
> >=20
> > > indicate more clearly that programmatic maps in principle return =
a
> > > single entry
> >=20
> > Maybe but isn't this in autofs(5) already close:
> >=20
> >    Executable Maps
> >        A map can be marked as executable. A program map will be cal=
led
> >        with the key as an argument. It may return no lines of outpu=
t
> >        if there's an error, or one or more lines containing a map e=
ntry
> >        (with \ quoting line breaks). The map entry corresponds to w=
hat
> >        would normally follow a map key.
>=20
> I guess.. it's just that you read over "a map entry" as meaning "only=
 a=20
> single map entry" since just before it says "one or more lines". So i=
t=20
> is something you only notice if you reread it in detail. After findin=
g=20
> out that it doesn't work ;-).
>=20
>=20
>=20
> > Isn't this near the top of autofs(5) sufficient:
> >=20
> >        key [-options] location
> >=20
> >        key
> >               For indirect mounts this is the part of the path
> >               name between the mount point and the path into
> >               the filesystem when it is mounted. Usually you
> >               can think about the key as a sub-directory name
> >               below the autofs managed mount point.
> >=20
> >               For direct mounts this is the full path of each
> >               mount point. This map is always associated with
> >               the /- mount point in the master map.
>=20
> Yes it is, particularly because it mentions that it is a sub-director=
y=20
> name.
>=20
> Then, I begin to wonder what "usually" means. See, from the looks of =
it=20
> it is completely identical to sub-directory name, because:
>=20
> - they key is going to be directly used as the name of the subdirecto=
ry
> - programmatically, the script does not even have any say about the k=
ey,=20
> it cannot even return a key, does not determine the key. The only thi=
ng=20
> that can ever happen is that the key as given is turned into a=20
> subdirectory (when valid).

Yeah, I get what your saying and it makes sense.
But it could be a wildcard ....=20

>=20
> I mean the logical abstraction between "key" and "value" may make sen=
se=20
> from a purely abstract logical point of view ;-). But it has no beari=
ng=20
> on actual domain-specific termininology, it is just a computer scienc=
e=20
> term so to speak.
>=20
> What it actually comes down to is:
>=20
> - mount point for the actual share, or
> - subdirectory created as mountpoint for the actual share(s).
>=20
> Where "value" would mean:
>=20
> - path to the mount (share), or
> - network path to the share that gets mounted on the subdirectory (th=
e=20
> key).
>=20
> the "mount" utility calls these source and target, respectively (sour=
ce=20
> for the path, target for the mount point). Otherwise it calls them=20
> "device" and "mountpoint".
>=20
> So although "key" also has meaning with regards to "database lookup" =
I=20
> don't see how it is ever not directly used as the mountpoint itself. =
And=20
> this is what creates the confusion because with the "browse" option i=
t=20
> is not just going to be a "lookup key".

=46rom automount(8)s POV it is always a lookup key that it wants to mat=
ch to a
mount location.

>=20
> Further there is no difference between "subdirectory mount point" and=
=20
> "lookup key", where these are fundamentally separate concepts, and co=
uld=20
> even imply, in principle, that the actual directory to use is *also*=20
> retrieved by the key.
>=20
> So conceptually the idea that "key" instantly means "subdirectory=20
> mount-point" is confusing.
>=20
> In fact it is odd to begin with, from the perspective of a user, that=
=20
> "auto.smb" mounts the entire share list of the requested "host" or "k=
ey"=20
> in one go under the location that was accessed.

Yeah but I'm not going to get to excited about an example program map t=
hat gets
installed by the package.

>=20
> This is not the most common scenario (well, maybe if you are in some =
big=20
> network). This is not most common not only because it mounts /all/ th=
e=20
> shares at once(!) but also because generally people want to have some=
=20
> level of control over the directory it ends up in, and what is the ho=
st=20
> for some server (hostname) might not be where you actually want to mo=
unt=20
> it.

Sure it is a bit of a hurdle but the autofs internal hosts map works th=
at way
and has been an expected automount feature for a long time.

I agree that doesn't cater for new users and I don't find creating and
maintaining web presences at all pleasant, quite the opposite, so a wik=
i for
this sort of information is probably not going to happen any time soon.

>=20
> So I suggest that even this auto.smb is a bit of a weird entity. I ha=
ve=20
> used it to generate a map list for me that I then adjusted and used a=
s a=20
> static map file.
>=20
> I know it does the same as that -net or -host thing. It's just that f=
or=20
> a desktop user (again, you say that is not the target audience, but=20
> still) what you really want is a fixed location the user chooses (in=20
> auto.master) and then a browseable list of shares. Apparently this li=
st=20
> needs to be static. What I envisioned before would be a parameter to =
a=20
> script that causes it to output a list of shares rather than the shar=
e=20
> entries themselves, or just the complete list of it.
>=20
> This would give it "browse" capability. If you had that, you would ne=
ed=20
> to be able to pass a parameter to the script as the key, but this is=20
> rather obscure.
>=20
> What it comes down to is that this is what I would envision for mysel=
f:
>=20
> Auto.master:
>=20
> /cifs   /etc/auto.smb   diskstation                <-- diskstation is=
=20
> the key
>=20
> Now the program/daemon/whatever passes diskstation as key to the scri=
pt.=20
> It also passes a wildcard parameter such as "*". The script now retur=
ns=20
> a list of shares for "diskstation". Subsequently when the daemon need=
s=20
> to mount, it calls the script with diskstation and the requested moun=
t=20
> point/share. Alternatively, the returned output from the first call m=
ust=20
> be complete and is saved by the daemon. It is then used in place of a=
=20
> static map (the script is now nothing but a static map generator).
>=20
> Personally I prefer the former: the script has two modes: list and=20
> return entry, and it therefore has two parameters: one to identify wh=
at=20
> to list, and the second to determine what entry to return from what w=
as=20
> listed.

I have thought about it a number of times.

It is necessary to remember that whatever is done must be backward comp=
atible
for existing users program maps.

One though was similar to your suggestion above, where diskstation woul=
d be
introduced as a mount option, understood to be a program map parameter =
by
automount(8) for certain lookup operations like the lookup module readm=
ap entry
point.

That's about the closest I've come to something that should work.
Still I haven't actually implemented it.

There's still a lot of detail about this approach that is unclear thoug=
h, such
as what should the parameter be, how many would be needed, where to sto=
re it
internally, etc.

>=20
> Otherwise, without the parameter, you'd need to hardcode it in the=20
> script and duplicate the script for every host, etc.
>=20
> In fact as a user you may not even want all shares to be present on y=
our=20
> local system. So you might equally well decide to use a static map. S=
o=20
> perhaps you will use "smb.auto list" or "smb.auto list diskstation" o=
r=20
> "smb.auto diskstation *" manually. And perhaps it generates all of th=
e=20
> mappings for you that you can then prune and save.
>=20
> Perhaps, in absense of the key (the entry, or wildcard) a call such a=
s=20
> "smb.auto diskstation" should simply generate the share list, whereas=
=20
> "smb.auto diskstation media" generates the key for only that entry.
>=20
> So you see me use a term like "entry" to determine what you today cal=
l a=20
> "key" and the word "key" to determine what you today call a "entry" ;=
-).
>=20
> "entry" means "element of pre-existing list", "key" means "value to u=
se=20
> for a lookup operation in a database".
>=20
> "key" can also mean "that what you need to mount or access something"=
=2E
>=20
>=20
>=20
> so if you combine the two, you have like three things:
>=20
> - subdirectory (mount point)
> - key to use for database lookup
> - entry in the list of shares
>=20
> but you can only solve it if you differentiate between "lookup=20
> operation" and "element of a list".
>=20
> a lookup operation may /return/ a list, which is why I said:
>=20
> "diskstation" (hostname) is a key
> list of shares is the result of that lookup operation based on that k=
ey
> entry is an element of that list you can mount.
>=20
> This applies to a form of browse scenario. If you have invisible=20
> mounpoint, you get:
>=20
> "diskstation" (hostname) is a key that is going to be a direct=20
> subdirectory
> the list of shares it returns is going to be a subdirectory list to t=
hat=20
> first subdirectory
> this will contain the actual shares, so you get top/key/entries.
>=20
> And you see we basically have the same thing except that this is one=20
> level deeper in our hierarchy.
>=20
> In my desired use case, you get:
>=20
> top/entry
>=20
> But in the current implementation of e.g. smb.auto, you get:
>=20
> top/key/entry
>=20
> So it is clear diskstation (hostname) IS a key, except that in the=20
> current case or scenario this key is ALSO used as the direct descende=
nt=20
> of the toplevel directory used for the configuration in auto.master.
>=20
> Which gives rise to the idea that maybe "key" and "subdirectory mount=
=20
> point" should not be equivalent or identical. Not necessarily identic=
al.
>=20
>=20
> In fact, smb.auto DOES produce a browsable list. It is just /beneath/=
=20
> the subdirectory for its "key" (the hostname) and mounts ALL of the=20
> shares at once.

Actually it doesn't actually mount the shares.

It mounts autofs trigger mounts that will cause the actual share to be =
mounted
on access.

>=20
> So you now already have that mountstorm (it just gets mounted by=20
> default) it's just a level deeper.
>=20
> You now don't have a mountstorm on the level of hosts, but you have a=
=20
> mountstorm on the level of shares (per host) but it is still the same=
=20
> thing.
>=20
> So the design specifies that keys must become mountpoints in the=20
> "sub-top-level" directory (the directory managed by autofs for indire=
ct=20
> mounts).
>=20
> Whereas perhaps conceptually you would need to differentiate between=20
> key, and an entry used for mounting, and the difference is that this=20
> entry used for mounting can be an element of the list returned by the=
=20
> key.
>=20
> So you get key -> list -> entries. In the case of current auto.smb, w=
hat=20
> happens is:
>=20
> key -> (subdirectory) -> list (itself an entry) -> entries.
>=20
> Or in other words:
>=20
> key -> list -> entries, but mounted beneath top/key, as key is used a=
s=20
> an extra directory in between.
>=20
> Current auto.smb:
>=20
>   <managed mount point>   /    <key>   /   entries  / contents of sha=
res
>=20
> My preference:
>=20
>   <managed mount point>   /    entries     /   contents of shares
>=20
> And why? Only because I want to specify mount points for specific hos=
ts=20
> manually.

auto.smb is an example program map.

Your free to implement your own program map any way you wish.

The thing that gets passed to the program map is a string that represen=
ts the
trailing path component of a path the kernel believes needs something d=
one to
it, be it symlink it somewhere, bind mount it somewhere or lookup a loc=
ation and
mount that on it etc.

You must adhere to that restriction because that's how automounts are t=
riggered.

>=20
>=20
>=20
> So the question becomes how you can combine such things.
>=20
>=20
> The requirement becomes for the script to return the mount point. A=20
> static list does return mount points. A script does not, the mount po=
int=20
> is specified as the "key" given to it. So if you want the script to=20
> determine the mount point the way a static list does, you need it to=20
> return, in essence, a static list.
>=20
> Even if your static list is not browseable, so too can a returned=20
> "dynamic list" also be not browseable. But at this point your script =
can=20
> return a mount point of its own. That is again problematic if the key=
 is=20
> derived from filesystem access.
>=20
> So you see how hard this is to reconcile.
>=20
> If we insist in accessing hidden shares and deriving keys from user=20
> action or filesystem action, or filesystem access, then keys are=20
> predetermined the moment the system is actually called. The script or=
=20
> database can only return whether something is gonna be there or not.
>=20
> Then the only way to reconcile it is (in my case) for the key to be n=
ot=20
> the only argument to the script, but I give the script my argument I=20
> define in auto.master:
>=20
> /cifs   /etc/auto.smb   diskstation
>=20
> Now my script knows that e.g. $1 is gonna be the filesystem requested=
=20
> path, and $2 is gonna be the custom parameter I determined in advance=
=2E
>=20
> I don't need to use the key by itself ($1) to do the lookup. My real =
key=20
> is $2. But I will use the second key ($1) to return a share for the h=
ost=20
> determined by the first key ($2).
>=20
> In essence what happens with auto.smb is that the key ($1) is used as=
=20
> the host (first key) and smb.auto will itself derive and load the lis=
t=20
> of shares, and then instantly mount that (it retrieves all of the sec=
ond=20
> keys and instantly uses that and mounts everything).
>=20
> autofs allows for this second list of keys to be instantly used and=20
> utilized.

One other consideration is the lazy mounting (and umounting) of these m=
ulti
-level mount trees that autofs manages.

It's very easy to get that wrong and end up with an inoperable mount po=
int that
cannot be recovered.

At the moment automount(8) will do that for you and occasionally gets c=
onfused
itself.

To do what is wanted here it would be necessary have a way to tell auto=
mount(8)
leave the mountpoint alone.

>=20
> But it's not the common use case because you are now fixed to that=20
> location the user accesses and of course you could use that location=20
> (the key) ($1) to look up a host in a different way, that is perfectl=
y=20
> possible. If your script marries "diskstation" to "ds" or "ds" to=20
> "diskstation" then you could automount /cifs/ds and it would request=20
> shares from host "diskstation".
>=20
> But you're still stuck with that intermediate level, that extra level=
 of=20
> subdirectories.
>=20
> It's not possible currently to use the "first key" to determine the h=
ost=20
> and then get the "second keys" ($1) to determine the entries. Well,=20
> actually it is, but not in a browseable fashion:
>=20
> /cifs   /etc/auto.smb   -Dhost=3Ddiskstation
>=20
>=20
> I believe this could work. You pass your real "primary" key as that=20
> variable, and your script returns shares based on that key, but with =
the=20
> "filesystem key" ($1) as the name of the share to return.
>=20
> Still, rather convoluted at this point, and not possible to browse th=
is=20
> list.
>=20
> Because it doesn't return a list. Using $2 to pass that variable=20
> wouldn't really be different.
>=20
> But the script is only called when an entry is accessed (through the=20
> filesystem) and as such is never called without a secondary key.
>=20
> The current auto.smb doesn't have secondary keys, it loads and mounts=
=20
> all of them instantly and automatically, and there is no "automount" =
for=20
> the secondary level.
>=20
> Well, there is, it just mounts all of it in one go.
>=20
> So how do you skip the intermediate level?
>=20
> - call the script on purpose to generate a 'static list' instead of j=
ust=20
> for entries alone.
>=20
> - use the static list to precreate directories (mount points), or
>=20
> - use the static list to return readdir information, or to filter=20
> requests for directories, or don't use the static list at all and jus=
t=20
> keep it the same.
>=20
>=20
> So we also see here that the static list *could* be used for the thin=
g=20
> you described above, that alternative readdir implementation.
>=20
> Although it's a bit of a hack, I'm sure.
>=20
> You could specify some interval for invalidating the list. At which=20
> point it is renewed by another "get list" call to the script.
>=20
>=20
> So in essence I am really advocating "return list" functionality for=20
> scripts here.
>=20
> And there is no easy way to implement that while staying compatible w=
ith=20
> current scripts because you would need to: call the script with an em=
pty=20
> parameter (that will never return an entry) or with a wildcard (that=20
> will probably never return an entry) and in essence, that might just =
as=20
> well mean, that if you want to take this approach:

Umm .. I think the other possibility is that if you pass an empty strin=
g to an
old program map you might cause it to crash.

> - use the wildcard as the "list" operation, scripts that do not know=20
> about the wildcard will simply return zero entries.
> - use the extra parameter as $2, in other words: allow for additional=
=20
> parameters in auto.master in that form of:
>=20
> /cifs   /etc/auto.smb   diskstation random
>=20
> But there are already recognised options. So what we have today (-D) =
I=20
> guess already works, it is just a bit obscure, and it seems to be the=
=20
> equivalent of what you would do.
>=20
> Then an alternative auto.smb (I called it auto-short.smb) would:
>=20
> - be called as:
>=20
> /cifs   /etc/auto.smb   -Dhost=3Ddiskstation
>=20
> - return a list of shares when called with "host=3Ddiskstation=20
> /etc/auto.smb *"
> - alternatively you could have it be called with: "/etc/auto.smb *=20
> diskstation"
>=20
> - make sure the shell doesn't expand that * ;-).
>=20
> - autofs calls this list operation each time auto.master is reread.
>=20
> - autofs calls this list operation each time some invalidation timeou=
t=20
> occurs
>=20
> - not really any other way to trigger it.
>=20
> - the static list being returned (really a dynamic list now) can be u=
sed=20
> for readdir, or even access filtering (it contains all the valid keys=
).
>=20
>=20
> Now when you have something like this, you can:
>=20
> - call the filesystem component you use to access the actual shares, =
the=20
> "entry" or simply "share" or "directory". But "key" becomes more=20
> comprehensible now as well. "key" now corresponds to "entries in the=20
> returned list". Each "entry in the returned list" is now a "mapping=20
> between key (directory) and value (device-path). I realize "mount poi=
nt"=20
> might confuse with the mountpoint defined in the master file.
>=20
> "submount" would be ugly. "subdir" is most convenient. "subkey" is=20
> illustrative. "entry" describes the entire thing, not just the key. B=
ut=20
> in essence we are just talking about a mount-point here.
>=20
> Nevertheless in principle the "first key" given should not even need =
to=20
> be the mount point in fact. It is a key to a lookup-table.
>=20
> If you wanted to do it right I think you would need to do away with=20
> hidden (or principally unknown) mount points, and basically always wo=
rk=20
> with static lists (or dynamically returned lists) and/or give every=20
> script a first parameter $1 that is a key that you actually use for i=
t.
>=20
> Then the second paramter $2 would be the key that the filesystem has=20
> actually given you for accessing a path.
>=20
> In this way "access path" becomes secondary.
>=20
> Perhaps a script in this way still cannot control the mount point (na=
me)=20
> but at least now it provides it in advance. Of course there are=20
> situations in which you cannot know it in advance or in which it is=20
> irrelevant to know it in advance.
>=20
> You can imagine a list to be much too big to actually retrieve it. In=
=20
> itself a sign of a bad system, I think. If it was that big, you would=
=20
> need hierarchy to make it smaller.
>=20
> So I don't know if there is ever any real need for obscurity, and for=
=20
> hosts to be accessed while not being able to list them in advance.
>=20
> I conjecture that this use case in itself would be odd, that you crea=
te=20
> auto-mounts for an unspecified number of hosts you don't really know=20
> about in advance.
>=20
> It makes for zero-configuration, true. You don't have to keep a list=20
> anywhere or even arrange for it to be generated.
>=20
> On the other hand if a list could not be had, the script would just=20
> return nothing and the daemon will assume no-browse=20
> no-information-in-advance lookups the way it does today.
>=20
> Basically if you keep the current $1 and use it to pass a wildcard, n=
o=20
> script is likely to ever break on that (it will just return nothing).=
=20
> Then $2 can be your primary key. Not every script needs it.
>=20
> But complete zero-configuration is to me an odd thing: a magical=20
> directory that will mount every host given to it including all of its=
=20
> shares, does not seem sensible to me in the sense that you would at=20
> /least/ want some configuration for every system right?
>=20
> One size fits all: the same system for every computer, just place it=20
> somewhere in your filesystem and you have access to everything and=20
> everything.
>=20
> No, normally you would want to tailor it because you do not have acce=
ss=20
> to an infinite amount of hosts and the /cifs/host/share structure=20
> therefore makes not much sense.
>=20
> /device/share may make more sense, perhaps added with
> /hosts/hosts-meeting-a-certain-pattern/share
>=20
> You already have a pretty big system if you use the latter. Anyway.
>=20
> I think I should conclude this :p.
>=20
>=20
>=20
> What seems sensible to me at least is to add something that doesn't=20
> break compability by using a wildcard * for scripts that will return =
a=20
> certain format of list (or just all shares it can find in the regular=
=20
> format) with a $2 parameter designating something such as a "host" or=
=20
> perhaps even "department".
>=20
> In this way you solve the issue that the current auto.smb requires th=
e=20
> "hostname" to be first key given to it because there is no other way =
to=20
> pass a key. Then the actual keys can be passed as "second parameter" =
in=20
> this sense that they still become $1, but at least now you can specif=
y=20
> your host to it in advance instead of guessing it on the wind ;-).
>=20
> So if I have to say anything I would say that I recommend this=20
> structure:
>=20
> - $1 remains the filesystem key
> - $2 becomes the additional key a user may specify in auto.master
> - $1 as * will designate the request for a list lookup
> - the list can in the future be used for readdir implementation, and=20
> currently for precreated mountpoints in case "browse" is used.
>=20
>=20
>=20
>=20
>=20
> > > indicate that this is true for "no browse" on "static maps" as we=
ll,=20
> > > and
> > > that directories are only created when they are accessed.
> >=20
> > That seems to be missing from the man page.
> >=20
> > > And that no-browse is the configured default.
> >=20
> > Not sure about that either.
> >=20
> > This (from auto.master(5)) says that I have made "browse" the inter=
nal=20
> > program
> > default way back when version 5 was first developed but I install a
> > configuration that turns it off because of (because of the above=20
> > problems, which
> > are not spelled out in the man page):
> >=20
> >      [no]browse
> >             This is an autofs specific option that is a pseudo moun=
t
> >             option and so is given without a leading dash. Use of t=
he
> >             browse option pre-creates mount point directories for
> >             indirect mount maps so the map keys can be seen in a
> >             directory listing without being mounted. Use of this
> >             option can cause  performance problem if the indirect
> >             map is large so it should be used with caution. The
> >             internal program default is to enable browse mode for
> >             indirect mounts but the default installed configuration
> >             overrides this by setting BROWSE_MODE to "no" because
> >             of the potential performance problem.
>=20
> I know, but if you, as a user, do not understand what the hell it is=20
> doing in the first place, and you have no time for extensive manual=20
> reading in advance (like me) you will never get to that option becaus=
e=20
> you still don't understand the basics, and the more advanced stuff (l=
ike=20
> that) that will be too hard to understand.
>=20
> That information is too difficult to comprehend (or digest) when you =
are=20
> someone who still doesn't understand how it works.
>=20
>=20
>=20
> > > I think that limitation indicates why using relative paths is so =
much
> > > more pleasant. A map file using relative files can be "moved arou=
nd".=20
> > > A
> > > map file using absolute paths cannot.
> > >=20
> > > Could you not make a direct map out of the key of the master file=
, and
> > > the keys of the sub-maps?
> >=20
> > Can't really do that.
>=20
> It's not that I saw it as necessary, I just still think the differenc=
e=20
> and distinction between "direct" and "indirect" is rather I dunno, we=
ird=20
> I guess ;-).
>=20
>=20
>=20
> > The closest thing to that would be multi-mount map entries, again f=
rom
> > autofs(5):
> >=20
> >    Multiple Mounts
> >        A multi-mount map can be used to name multiple filesystems
> >        to mount. It takes the form:
> >=20
> >        key [ -options ] \
> >            [[/] location \
> >           [/relative-mount-point [ -options ] location...]...
> >=20
> >        This may extend over multiple lines, quoting the line-breaks=
=20
> > with
> >        `\=C2=B4.  If present, the per-mountpoint mount-options are =
appended
> >        to the default mount-options. This behaviour may be overridd=
en
> >        by the append_options configuration setting.
>=20
> Something I am already using (almost) and I believe this is what=20
> auto.smb uses by default too. It's just that I use it to mount parts =
of=20
> the same share. (Samba smbd often has issues with file-system boundar=
ies=20
> so I create a share out of each filesystem and share them individuall=
y,=20
> then mount them as above).

It does, yes.

>=20
>=20
>=20
> > >=20
> > > normally ( /bla/bla ) indicates an absolute path and can only be =
used=20
> > > in
> > > a direct map, from what I've seen. You *could* cause it to turn t=
his
> > > "indirect map" into a direct one.
> > >=20
> > > ie. ( bla/bla ) =3D=3D indirect
> > >      ( /bla/bla ) =3D=3D direct.
> >=20
> > In the Sun map format maps indirect mount map keys are a single pat=
h=20
> > component
> > only.
> >=20
> > The situation is different if using amd format maps but I could wor=
k=20
> > out how
> > direct mount maps could be usefully used so that mount type has not=
=20
> > been
> > implemented. Even on Solaris where they are supposed to be fully=20
> > supported I
> > could make sense of them.
> >=20
>=20
>=20
>=20
> > > /start/of/the/-  ( path )
> > >=20
> > > Then any path in the master file ending with /- would be a direct=
=20
> > > path.
> > >=20
> > > And would cause the (static) map file to be treated as direct.
> >=20
> > Nope, that is unlikely to work and would lead to a lot of problems.
> >=20
> > One example might be with:
> >=20
> > /start/of/the/-/path
> >=20
> > people will ask where have the directories below /start/of/the/ gon=
e=20
> > and the
> > answer will be they have been covered by the autofs file system mou=
nt.
>=20
> But that's no different from a regular mount on that location.
>=20
>=20
> > Next it would be but I should be able to see these, surely that's e=
asy=20
> > to fix.
> >=20
> > At hat point I would probably leave the conversation.
>=20
> :-). Haha. But come on, you can't take that seriously, the same thing=
=20
> happens with a regular mount, even a bind mount does that. It's=20
> absolutely not possible to reveal the contents of some subtree when=20
> another filesystem had mounted on top of it, except by remounting the=
=20
> entire subtree elsewhere.
>=20
> (I am trying out some gimmick that requires me to mount the root devi=
ce=20
> under something like /run/mount/rootfsclone, because I am bind mounti=
ng=20
> on top of something that I still want to be accessible. The only way =
to=20
> make it accessible is to mount the entire rootfs somewhere else. I=20
> basically need a persistent location for individual devices without=20
> anything mounted on top of them; ie. a pure one-file-system mount tre=
e.
>=20
> Then you have those individual mount-trees (filesystem trees) and THE=
N=20
> you have the complete FHS that you normally use.
>=20
> That seems like the only sensible way to approach a lot of issues.=20
> Having a /mounts/ with every (custom) mounted device present there.
>=20
> Recently the number of incomprensible mounts reported by "mount" has=20
> grown so big that the entire tool has become unusable, mostly due to=20
> cgroups. And tmpfs's, and debugfs's, and what not.
>=20
> I now find I need to create a wrapper for mount so that "mount" stays=
 at=20
> least usable to the user. Such that every subdirectory of /sys, and=20
> every subdirectory of /run, and every subdirectory of /dev/, is actua=
lly=20
> hidden from display. And from /proc as well. And the same applies to =
DF.
>=20
> (I really need to find a way to better save and redistribute these=20
> modifications).

Oddly enough, a pseudo mount option like "hidden", visible in the /proc=
 files
but left out by utilities like mount, df etc. is what could be done, an=
d should
be done, IMHO, but no-one wants to do it!

>=20
>=20
>=20
>=20
>=20
>=20
> >=20
> > In any case a similar thing, but more explicit and I think easier t=
o=20
> > follow and
> > maintain are the autofs multi-mount map entries, what I think you=20
> > called
> > relative path above.
> >=20
> > It isn't clear but that syntax should function within both direct a=
nd=20
> > indirect
> > mount maps.
> >=20
> > The problem with all this is that substitution cannot be used in th=
e=20
> > key.
> >=20
> > The reason for that is same as why the amd regex key matching has n=
ot=20
> > been
> > implemented.
> >=20
> > A linear map scan would be needed for every lookup in order to matc=
h=20
> > what has
> > been sent to us from the kernel. And as much as you might feel that=
=20
> > wouldn't be
> > a problem because maps are generally small I can assure you it woul=
d=20
> > make life
> > really unpleasant for me!
>=20
> :). You have lost of enemies; if you don't do things right :P. LOL.
>=20
> I am not thinking about this now, but I guess you mean that my propos=
ed=20
> solution of saving those static lists (or dynamic lists) would actual=
ly=20
> help this :p.
>=20
> Actually what you are saying is that even doing lookups on those list=
s I=20
> proposed would be quite annoying.
>=20
> However currently this lookup is already done on the server (if it is=
=20
> some database) or in the static map (if they are not browseable). Rig=
ht?

And in the locally cached map and quite frequently queried as part of t=
he expire
processing.

Direct maps and maps that have the browse option must be read completel=
y at
startup and are always present in local storage.

>=20
> Databases are generally better at lookup than small-scale application=
s.=20
> Now you need hash-tables etc. Anyway, I can't think about it right no=
w.
>=20
>=20
>=20
> > > I only noticed just now because autofs(8) references autofs(5), a=
nd=20
> > > I'm
> > > like ....huh?
> >=20
> > Yeah, that's what we have ....
>=20
>=20
>=20
>=20
> > > /media/*/nas    /etc/nas-shares.map
> >=20
> > Can't do that, each /media/*/nas needs to be mounted at program sta=
rt=20
> > so that
> > automounts can be done?
>=20
> Actually the shell easily expands such a pattern to all matching tree=
s?
>=20
> e.g. if you create /usr/local/doc, and then do
>=20
> "ls /usr/*/doc/" you will get the output of:
>=20
> /usr/local/doc  /usr/share/doc

automount is not a shell and doesn't have code to expand such things an=
d an
indirect mount may have a single map associated with the given mount po=
int path.

Way back it was possible to associate multiple maps with a given mount =
point
path but that functionality was removed because it was not a feature of=
 the Sun
automount system which autofs seeks to implement.

>=20
> So with that output, you mount all of them, all the while knowing tha=
t=20
> the middle component (here) is a wildcard. Then the daemon knows abou=
t=20
> this wildcard and can use it while processing /etc/nas-shares.map for=
=20
> each of them; but they are all individual mounts at that point.
>=20
> e.g.  /media/me/nas and /media/pamela/nas are now individual autofs=20
> mounts.
>=20
> but their "/etc/nas-shares.map" is called with a different wildcard.
>=20
>=20
> I mean that either /media/me/nas will already exist (precreated by th=
e=20
> user) or your program creates it (I think it already does that).

This is so far from what autofs is meant to implement I can't see it no=
t
interfering with what it is supposed to be doing.

>=20
> Actually it cannot create it DUH, so the user will need to precreate=20
> them.
>=20
>=20
> I know /media is usually seen as a managed directory but this is=20
> annoying in the first place. Such an important name (/media) and I=20
> cannot do anything with it because it is already taken. At the same t=
ime=20
> accessing it from your home directory is usually quite annoying. So i=
n=20
> order to make sense of it I must precreate /media/xen and=20
> /media/dannielle and prevent the daemon (that /media thing) from wipi=
ng=20
> them.... buh.
>=20
> The funny thing is that /media/xen is not even owned by xen.
>=20
> The subfolders are, but the thing itself isn't (how stupid?).
>=20
> So in this case perhaps not as convenient, but in the general case if=
 I=20
> precreate:
>=20
> /mytree/me/nas
> /mytree/quinty/nas
>=20
> etc.
>=20
> Then the daemon could read
>=20
> /mytree/*/nas
>=20
> on program start and see all the shares that match. All the directori=
es=20
> that match.
>=20
> Then it knows that "me" and "quinty" are wildcard entries for their=20
> respective mounts.
>=20
>=20
>=20
>=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > > By definition a program map can't know what keys may be passed =
to it.
> > > > And, yes, even autofs(5) doesn't say explicitly that a program =
map
> > > > doesn't know
> > > > what keys may be passed to it, perhaps that should be ammended.
> > >=20
> > > In principle even a program map could read all of the available k=
eys
> > > from whatever database it consults, and return all of them; or re=
turn
> > > something only (as it does now, perhaps) when a given key matches=
 (is
> > > found).
> >=20
> > I've thought of that too.
> >=20
> > But I've resisted because I'm concerned about confusing existing=20
> > program maps
> > people have in unpleasant ways.
>=20
> At some point you need to be willing to break previous compability.
>=20
> I understand that Linux is usually a running-upgrade system and even =
if=20
> people do upgrade entire distributions they want the system to keep=20
> functioning as normal without changing anything.
>=20
> But e.g. the Debian update program can tell you stuff like "This pack=
age=20
> does something different now, and you need to ensure it can either=20
> handle or ignore the wildcard".
>=20
> on every package installation.
>=20
>=20
>=20
> > That's not a bad thought, but what would $1 be so that older script=
s=20
> > wouldn't
> > choke on it.
>=20
> I had suggested * because there is no hostname called *.
>=20
> But scripts may very well mount local filesystems as well. And they=20
> might very well use a shell to do stuff like "[ -d $key ]" or "[ -d=20
> "$key" ]" and....
>=20
> And as always, stuff breaks a lot when people don't use "$key". If=20
> people's scripts are badly written then [ -d $key ] will malfunction.
>=20
> In order to cover that you would have to use something like "_", no o=
ne=20
> is going to use _ as an actual filename.
>=20
>=20
>=20
>=20
>=20
> >=20
> > >=20
> > > So, for instance, if $2 is "browse" the script may choose to retu=
rn a
> > > browse map, or list of shares, with whatever options are availabl=
e (it
> > > could even return the UID/USER of the share given options, so tha=
t the
> > > created directory would have the same UID as the to be mounted sh=
are!)
> > > -- meaning it might simply return ALL entries it could possibly r=
eturn
> > > in the default format, which is the meaning of the wildcard, and =
the
> > > program (autofs daemon or module(?)) would be able to generate th=
e
> > > appropriate directory entries based on that. So in that case you'=
re
> > > probably going to be rid of the problem of the non-matching state=
 of
> > > pre- and post-mount of directories.
> >=20
> > which pretty much defeats the only possible solution I can think of=
 for=20
> > "browse"
> > option mounts ...
>=20
> You mean the one suggested above. But if you make an alternative read=
dir=20
> having a list available won't bug you right?
>=20
> I mean, having mount information available in advance cannot be a=20
> problem, only a help.
>=20
>=20
>=20
>=20
> > Like I said, I wanted to have the default as "browse" but got hit w=
ith=20
> > too many
> > complaints and was only willing to change the package installed def=
ault
> > configuration to satisfy them.
> >=20
> > I'm not going to try that again.
>=20
> "Design by committee" they call it ;-).
>=20
> Someone told me that OpenSUSE has had "browse" as the default for at=20
> least 5 years.
>=20
> You did think about making a distinction between static and LDAP/NIS=20
> maps? I'm not sure I am not crossing my bounds here now ;-). Seeing t=
hat=20
> I already suggested it.
>=20
>=20
>=20
>=20
>=20
> > > In this way no one can ever get confused, so you might just renam=
e
> > > autofs(5) to autofs.map(5).
> >=20
> > Yeah maybe ...
> >=20
>=20
> > > I will look into providing a patch, but I hope you can rename=20
> > > autofs(5)
> > > to autofs.map(5) before doing anything like that. I don't feel li=
ke
> > > improving a system I know myself haven't had access to, in that s=
ense.=20
> > > I
> > > don't mean you have to do that straight away, but if that is a=20
> > > possible
> > > direction to go, or change to make, then I could supply a patch o=
r
> > > anything based on the system that would result from that, seeing =
that
> > > autofs(5) is already pretty good in that sense.
> >=20
> > At some point I'll need to return to this and make a list.
> > Unfortunately that time isn't now.
>=20
>=20
> Here is just my short summarize:
>=20
>=20
> - suggested compromise between browse and nobrowse by only making bro=
wse=20
> for static lists the default to please new people unaware of what wil=
l=20
> happen
>=20
> - suggested perhaps using _ as the wildcard key, not using that "brow=
se"=20
> flag as $2, but allowing a different "primary" key as $2 if the scrip=
t=20
> wants it.
>=20
> - suggested changing autofs(5) to autofs.map(5) such that users will =
be=20
> able to find it.
>=20
> And the rest is up to you, I think you don't need anyone rewriting it=
=20
> for you now, but I could still try my hand if that was necessary. I j=
ust=20
> think using better terminology is dependent on the first two suggesti=
ons=20
> here, particularly perhaps the second, and otherwise you'll have to=20
> explain current terminology better and create some way to separate "k=
ey"=20
> in auto.master from "key" in "autofs.map" ;-).
>=20
> However if scripts could accept an additional "key" and the default=20
> operation or capability would for them to be able to return a "list"=20
> then it would become more clear that the additional "key" would be th=
e=20
> index to retrieve that list, and that the entries resulting from that=
=20
> may have their own "keys" but these "keys" are then used for the=20
> individual "mount points".
>=20
> So then you have reason to call the entry keys "entry keys" and the=20
> other ones "lookup keys" for instance. Then, static maps use "entry=20
> keys" but scripts have "lookup keys" as their 2nd parameter. The scri=
pt=20
> then has "entry key" as the first, and "lookup key" as the second=20
> parameter. Then, entry key is equivalent to subdirectory, and lookup =
key=20
> is often going to be equivalent to e.g. hostname.
>=20
> A script without list functionality only accepts "entry keys" but may=
=20
> very well use them as lookup keys as well.
>=20
> A database also uses them as equivalent. But at least now you have=20
> something of a model to conceptually separate them. Since browse alre=
ady=20
> functions for e.g. LDAP, in many cases you will not use a lookup key =
for=20
> that, simply because (a) /etc/autofs_ldap_auth.conf already contains=20
> such paramters and (b) the other parameters are specified in the=20
> mapname-format for LDAP.
>=20
> So what we call "lookup key" would already be encoded in the LDAP URL=
=20
> but such a thing is not possible for scripts.
>=20
> So you could call scripts the exception to the rule in not having thi=
s.=20
> Of course it exists,: the "-D" parameters.
>=20
> (I think? Haven't tested it yet).
>=20
> So I don't know.
>=20
>=20
>=20
>=20
> For a database the entry key is always going to be a lookup key to th=
e=20
> database.
> Entry keys can also result from a list fetch.
>=20
> So they can result from filesystem access or from some list retrieval=
=2E
>=20
> But if "browse" becomes more normal and standard, you would see that =
it=20
> becomes easier to talk about this "entries from the list you get when=
=20
> quering the database/script for it".
>=20
> Then the gap between "entries from the list" and "subdirectories=20
> created" is smaller than the gap between "filesystem access" and=20
> "subdirectories created".
>=20
> Meaning: key (database designator) -> list -> entries (database entri=
es)=20
> is conceptually easier to grasp than key (filesystem access) -> entry=
=20
> (database entry).
>=20
> Or key (filesystem access) -> database lookup -> entry.
>=20
> Simply because it is hard to understand that user action (filesystem=20
> lookup) is the input to the entire system and is actually the keys be=
ing=20
> used.
>=20
> Even if it's not always to be used, having a level in between that ti=
es=20
> "key" to "pre-existing shares" or "pre-existing entries" becomes easi=
er.=20
> When a user thinks of "key" they think about either existing shares o=
r=20
> existing hosts.
>=20
> Then conceptually it is logical to assume that the script or database=
=20
> can give back this list. And that either this list is precreated on t=
he=20
> harddrive, or at least that it is used to match the "keys" against, f=
or=20
> instance.
>=20
> (By harddrive I mean filesystem (hierarchy)).
>=20
> This is why I think standard operation for at least smaller lists sho=
uld=20
> be a form of browse or at least a form of list retrieval, if you are=20
> going to have dynamically generated lists in any case.
>=20
> Then, it conforms more to a sense of what a general computer user is=20
> going to have of the idea of auto-mounting mount-points. It (he/she)=20
> thinks those mount-points are already going to exist, prior to being=20
> automounted.
>=20
> This in turn makes it easier to explain that the key is really a=20
> subdirectory, and that there can be another key if needed to specify =
the=20
> host, or something of the kind.
>=20
> Then, the most common use case for a new or general computer user=20
> wanting to try this is going to be met, because that use case is goin=
g=20
> to involve auto-mounting network-shares of which there is a limited=20
> number.
>=20
> And it will involve something like
>=20
> /nas/media
> /nas/backup
> /nas/home
>=20
> etc.
>=20
> Now I'm not sure if it covers the entire use. But at least you'd also=
=20
> have a script that can generate a static map for you that you can the=
n=20
> use in place of the scripts, if you want to prune the mounts that are=
=20
> actually visible to you.
>=20
> Apart from the distributions themselves there is not really any softw=
are=20
> in the Linux world that is tailored to either the desktop user, or th=
e=20
> server user, but not both, is there?
>=20
> Apart from the desktop environments.
>=20
> Anyway this was a long read and write, I guess, for both of us :P.
>=20
> Time to get some food again or at least some water :p.
>=20
> See ya.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
