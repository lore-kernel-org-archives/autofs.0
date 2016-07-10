From: Xen <list@xenhideout.nl>
Subject: Re: documentation issues
Date: Sun, 10 Jul 2016 19:07:24 +0200
Message-ID: <9c9a4677493eb868dc68f02d8e5b10c7@dds.nl>
References: <cec586e96030cbbc150886909bf34a45@dds.nl>
 <1467766653.4580.46.camel@themaw.net>
 <120efa5371880caa1f603fb7a4cded84@dds.nl>
 <1467809314.4580.172.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1467809314.4580.172.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Autofs <autofs@vger.kernel.org>

Ian Kent schreef op 06-07-2016 14:48:

> But I don't understand your use of "lazy initialization".

I meant creating the mount point only when it was accessed.

> So I don't quite understand what your concern is.
> Sure, if you have hundreds or thousands of these there can be a=20
> performance
> problem but that's not what you were trying to do I thought.

I'm not sure either at this point but I'm too hungry to read back on=20
what I had written before :p.

> Of course, yes, program maps can never know in advance what key may b=
e=20
> passed to
> them.
>=20
> The problem is usually seen with user applications, cron jobs that sc=
an
> directories, GUI file management utilities etc.
>=20
> It's has been quite a problem over time.

Yes that is my concern. I do not like the idea of invisible access=20
points at all, unless I was doing it for security, but in that sense yo=
u=20
can't really hide anything in a Linux system. Invisible mount points=20
only make sense when you have LOTS of them and you only need few at a=20
time.


> LDAP is a map source, like a file, or nis etc.
>=20
> Maps stored in LDAP behave much the same as maps stored in files.

Right so you can browse them if you want.


>=20
>>=20
>> So then consider that we only use a static map here. An actual file=20
>> with
>> thousands of entries? Of course it can happen. But what would be the
>> point of that still (as opposed to LDAP or programmatic).
>=20
> People do seem to like program maps but plenty of people use static o=
r=20
> semi
> -static maps, ie. a bunch of entries followed by the wildcard map key=
=20
> "*"
> usually with some macro or "&" substution.
>=20
> Similarly, what might match the wildcard map entry can't be known in=20
> advance.

Right. That makes it programmatic; the (server) response will determine=
=20
if anything was actually there. On the other hand a wildcard (in a=20
direct map at least) may determine existing (or match existing)=20
filesystem components that you could read in advance. And you need to,=20
in a direct map. But direct maps are mounted anyway (or the mountpoint=20
is created, I mean). So it currently only applies to indirect maps wher=
e=20
the wildcard is the final component, and it then behaves like a=20
programmatic thing where it only actually gets mounted (and created) if=
=20
e.g. the server reponds with a share.


> It's hard enough for me to understand VFS path walking sufficiently=20
> without
> having to describe it too.

I don't know. I studied it in some detail, I just don't understand the=20
RCU algorithm. At least, I have studied path_lookupat and the entire=20
procedure leading up to lookup_fast and lookup_slow. I'd have to check=20
my printouts to say more. But let's just say I'm aware of any=20
(recursive) operation involving symlinks, where intermediate symlinks=20
get expanded before the original path is being continued, etc. I am als=
o=20
aware of the presence of autofs code, particularly in the function that=
=20
specifies one or two other mount things.

I believe that is called by lookup_slow....



> All I can say is there is a problem determining whether a call back t=
o=20
> the
> deamon is needed or not at the times the kernel module is called. Tha=
t=20
> can
> sometimes result in all entries in the autofs managed mount point=20
> directory
> being mounted.

So the mount point is accessed but the module doesn't know if anything=20
really needs to happen at that point. And stat operations or anything=20
else all use the same path lookup. Of course I don't know what happens=20
pre-mount and post-mount to the directory itself. If post-mount the=20
directory is really on another filesystem, the "mnt" value will change.=
=20
And it will return another dentry for that other mount. I remember=20
"path" being mnt+dentry.

>=20
> Another aspect of this problem is that the same system call may need =
to=20
> have the
> directory trigger a mount while not so at other times it's called and=
=20
> there's no
> way to tell what the usage is within in the kernel.

So you are getting called by lookup_slow or something of the kind near=20
it, but you're not sure why. But these lookups are being done for each=20
individual path componenent. However a "cd" to the directory should=20
mount it, but a mere "stat" may not. Is that the case? Seems odd that i=
t=20
would be difficult, but I believe you on your word.

Maybe "cd" shouldn't mount it until the contents is accessed, but I=20
don't know.


>=20
> So sometimes people get caught because they want their stat(2) call t=
o=20
> return
> the mounted file system results but not to cause a mount at other tim=
es=20
> when it
> might lead to a mount storm.

Hmm. It seems like the first desire is a problem. At least, I don't kno=
w=20
how directory lookup is done. I don't know if this information is the=20
result of a stat call or something else. I do remember seeing code for=20
dentry-moving but it was confusing.

=46or sure you want "ls /directory/" to return the mounted contents. Bu=
t=20
I'm not sure if its possible for your module to differentiate. Ls -d=20
"/directory/" should perhaps not cause mounting. I can see quickly=20
though that "ls" causes an "open" call but "ls -d" does not.

But then, "open" will not access any path components beyond the=20
directory itself. So if your module is only called by path_lookup it is=
=20
going to be impossible to know what for.

Particularly if an "ls" does not actually access path componenets=20
(beyond the directory itself) there would be no way to know what is=20
being asked.


> Usuall all I can say to them is don't use the "browse" option.....

:).


> It is a difficult problem and I'm inevitably caught in the middle=20
> between the
> "browse" and "nobrowse" camps.

You appear to be very conscientious about it.


> Not all cases of accessing such a directory will see this problem=20
> either but
> user space seems to have a habit of using system calls that don't=20
> trigger a
> mount together with others that do.

such as that "ls" vs "ls -d"?


> Causing the so called mount storm.

Still seems odd but I believe you, but. I guess what it could mean is=20
"ls" not only trying to list every share (browse) but also to perform=20
calls on those shares (path componenents retrieved) that might require=20
additional information. For example, if I am not content just knowing=20
the shares, but also want to know the number of files in them.... which=
=20
definitely some programs or user agents would do. Then I'm in trouble=20
because this requires mounting. Then, if that is the case, a simple

"list /nas/" might result in the subfolders (/nas/media, /nas/backup,=20
etc.) to also be queried and you have what you call a mount-storm.

But this is the result of user space convention and behaviour. Surely=20
people cannot request browse while at the same time wanting to deny=20
actions on the returned results when these actions stem completely from=
=20
userspace?

If some user agent or GUI is trying to list the number of files in each=
=20
directory (which at this point means a share) then that's not something=
=20
autofs could ever deal with. And I don't think it is a problem autofs=20
needs to solve.

If I am at all correct about this and I see what you mean right now,=20
this "GUI" behaviour would then simply be incompatible with unmounted=20
folders *that-might-need-to-get-mounted-but-not-always* and this GUI=20
would need to be aware to not do that thing.




>=20
> Having said that though, with a lot of work, I could probably do=20
> something about
> it.
>=20
> TBH I've avoided it because it is difficult, perhaps in version 6.
>=20
> It would require not pre-creating mount point directories and adding =
a=20
> readdir
> implementation to the kernel to fill in the names (map keys) that=20
> aren't already
> mounted. But that means significantly more (in terms of quantity of)
> communication between the daemon and the kernel module.
>=20
> That means re-writing the user space <-> kernel space communications=20
> completely
> in an incompatible manner to what is used now, not to mention=20
> significant
> changes to the user space code itself.
>=20
> A big job really.

And not a big joy perhaps.

So basically you are going to not precreate, but still hijack kernel=20
calls to return the listings for the directories that do not yet exist=20
(the listing of those directories).

Which means those directories could be shown, but not opened, or=20
something of the kind. Then, the user agent .. well I don't know what=20
difference it makes actually if the mount storm is the result of=20
userspace calls that directly cause it. So I guess I'm mistaken here an=
d=20
the issue is even more complex.... :(.

I don't know how a readdir on the "top" directory could /directly/=20
causes a mountstorm on the listed entries. But then, I don't know much=20
;-).


> It happens, from what I've seen, quite a bit.
> Perhaps you would be surprised.

Illuminate me :P. What is the most common cause of it?

> Yes, but network sources such as NIS and LDAP are treated much the sa=
me=20
> as a
> file map.

Yes, I didn't realize at the start. I have always found LDAP to be a=20
rather incomprehensible thing to work with. Without hands-on experience=
=20
it is hard to get a good grasp of how it works. Or even how to organise=
=20
it (if you do create one) as there seem to be standards for everything.


> Checking if a file map has been updated since a key was last used is=20
> easier with
> a file map and straight forward with a NIS map but can't sensibly be=20
> done for an
> LDAP map.

Right.

>=20
>>=20
>> Maybe I'm missing something here.
>>=20
>>=20
>> > Another reason for the default is that, because of this, historica=
lly
>> > there was
>> > no "browse" option and this maintains what is (should be) expected=
=2E
>>=20
>> Yeah I thought so, because of the comments near the timeout value.
>> However that is a reason to never change anything ever. Someone
>> mistakenly choosing "browse" will very quickly find out.
>=20
> And wouldn't itself be sufficient but for the problems I'm attempting=
=20
> to
> describe above.

You mean the mountstorm problems are reasons to keep the default at=20
no-browse?

It still seems at this point that this is only relevant for LDAP/NIS=20
entries.



>> First the auto.master file on my system mentions man autofs as a pla=
ce
>> for seeing the format of the (sub)map files. However there is nothin=
g=20
>> in
>> there. So that part is missing, but in a sense the contents of=20
>> auto.misc
>> is already somewhat sufficient for that, but still annoying that the=
re
>> is no man page.
>=20
> That doesn't sound right, there might be a problem with your=20
> distribution
> package.

No, as I say later this is incomprehension on my part ;-). Or merely th=
e=20
fact that needing to use "number" for accessing "sections" of the=20
"manual" is so rare (if you are not a developer accessing library=20
functions and/or kernel functions) that a regular user will almost NEVE=
R=20
use a section number in daily operation.

Most configuration files are called "openvpn.conf" or something of the=20
kind, and hence their manual page is also called that, and you don't=20
need to do "man 5 openvpn.conf", because "man openvpn.conf" is=20
sufficient.

Using numbers would be superfluous in 99% of cases, or even more than=20
that. As opposed to perhaps requesting help on function calls, such as=20
mount() as opposed to /bin/mount.

So as a developer you may be used to it. But a regular user is not.=20
Anyone who does not do C programming, is not.

So, my mistake, I guess.

>>=20
>> You don't imagine that every freaking access of a directory or path
>> component in the managed directory is going to result in network=20
>> access.
>>=20
>> You could do a "for f in `seq 1 10000000`; do vdir $f; done" and hav=
e
>> fun.
>>=20
>> (Don't know if that would still be the case for "browse" maps).
>>=20
>> So this hidden directory, secret door thing is really the most=20
>> confusing
>> of all.
>>=20
>> It's somewhat similar to something I might like to do, but still you
>> don't really expect it ;-).
>>=20
>> So the 3-4 things are:
>>=20
>> create a man page or section for the format of the sub-maps
>=20
> Already exists, needs work.
> Lets call these mount maps (not the best but the convention used) as=20
> opposed to
> the master map.

Alright. Still confusing though.

>=20
>> indicate more clearly that programmatic maps in principle return a
>> single entry
>=20
> Maybe but isn't this in autofs(5) already close:
>=20
>    Executable Maps
>        A map can be marked as executable. A program map will be calle=
d
>        with the key as an argument. It may return no lines of output
>        if there's an error, or one or more lines containing a map ent=
ry
>        (with \ quoting line breaks). The map entry corresponds to wha=
t
>        would normally follow a map key.

I guess.. it's just that you read over "a map entry" as meaning "only a=
=20
single map entry" since just before it says "one or more lines". So it=20
is something you only notice if you reread it in detail. After finding=20
out that it doesn't work ;-).



> Isn't this near the top of autofs(5) sufficient:
>=20
>        key [-options] location
>=20
>        key
>               For indirect mounts this is the part of the path
>               name between the mount point and the path into
>               the filesystem when it is mounted. Usually you
>               can think about the key as a sub-directory name
>               below the autofs managed mount point.
>=20
>               For direct mounts this is the full path of each
>               mount point. This map is always associated with
>               the /- mount point in the master map.

Yes it is, particularly because it mentions that it is a sub-directory=20
name.

Then, I begin to wonder what "usually" means. See, from the looks of it=
=20
it is completely identical to sub-directory name, because:

- they key is going to be directly used as the name of the subdirectory
- programmatically, the script does not even have any say about the key=
,=20
it cannot even return a key, does not determine the key. The only thing=
=20
that can ever happen is that the key as given is turned into a=20
subdirectory (when valid).

I mean the logical abstraction between "key" and "value" may make sense=
=20
from a purely abstract logical point of view ;-). But it has no bearing=
=20
on actual domain-specific termininology, it is just a computer science=20
term so to speak.

What it actually comes down to is:

- mount point for the actual share, or
- subdirectory created as mountpoint for the actual share(s).

Where "value" would mean:

- path to the mount (share), or
- network path to the share that gets mounted on the subdirectory (the=20
key).

the "mount" utility calls these source and target, respectively (source=
=20
for the path, target for the mount point). Otherwise it calls them=20
"device" and "mountpoint".

So although "key" also has meaning with regards to "database lookup" I=20
don't see how it is ever not directly used as the mountpoint itself. An=
d=20
this is what creates the confusion because with the "browse" option it=20
is not just going to be a "lookup key".

=46urther there is no difference between "subdirectory mount point" and=
=20
"lookup key", where these are fundamentally separate concepts, and coul=
d=20
even imply, in principle, that the actual directory to use is *also*=20
retrieved by the key.

So conceptually the idea that "key" instantly means "subdirectory=20
mount-point" is confusing.

In fact it is odd to begin with, from the perspective of a user, that=20
"auto.smb" mounts the entire share list of the requested "host" or "key=
"=20
in one go under the location that was accessed.

This is not the most common scenario (well, maybe if you are in some bi=
g=20
network). This is not most common not only because it mounts /all/ the=20
shares at once(!) but also because generally people want to have some=20
level of control over the directory it ends up in, and what is the host=
=20
for some server (hostname) might not be where you actually want to moun=
t=20
it.

So I suggest that even this auto.smb is a bit of a weird entity. I have=
=20
used it to generate a map list for me that I then adjusted and used as =
a=20
static map file.

I know it does the same as that -net or -host thing. It's just that for=
=20
a desktop user (again, you say that is not the target audience, but=20
still) what you really want is a fixed location the user chooses (in=20
auto.master) and then a browseable list of shares. Apparently this list=
=20
needs to be static. What I envisioned before would be a parameter to a=20
script that causes it to output a list of shares rather than the share=20
entries themselves, or just the complete list of it.

This would give it "browse" capability. If you had that, you would need=
=20
to be able to pass a parameter to the script as the key, but this is=20
rather obscure.

What it comes down to is that this is what I would envision for myself:

Auto.master:

/cifs   /etc/auto.smb   diskstation                <-- diskstation is=20
the key

Now the program/daemon/whatever passes diskstation as key to the script=
=2E=20
It also passes a wildcard parameter such as "*". The script now returns=
=20
a list of shares for "diskstation". Subsequently when the daemon needs=20
to mount, it calls the script with diskstation and the requested mount=20
point/share. Alternatively, the returned output from the first call mus=
t=20
be complete and is saved by the daemon. It is then used in place of a=20
static map (the script is now nothing but a static map generator).

Personally I prefer the former: the script has two modes: list and=20
return entry, and it therefore has two parameters: one to identify what=
=20
to list, and the second to determine what entry to return from what was=
=20
listed.

Otherwise, without the parameter, you'd need to hardcode it in the=20
script and duplicate the script for every host, etc.

In fact as a user you may not even want all shares to be present on you=
r=20
local system. So you might equally well decide to use a static map. So=20
perhaps you will use "smb.auto list" or "smb.auto list diskstation" or=20
"smb.auto diskstation *" manually. And perhaps it generates all of the=20
mappings for you that you can then prune and save.

Perhaps, in absense of the key (the entry, or wildcard) a call such as=20
"smb.auto diskstation" should simply generate the share list, whereas=20
"smb.auto diskstation media" generates the key for only that entry.

So you see me use a term like "entry" to determine what you today call =
a=20
"key" and the word "key" to determine what you today call a "entry" ;-)=
=2E

"entry" means "element of pre-existing list", "key" means "value to use=
=20
for a lookup operation in a database".

"key" can also mean "that what you need to mount or access something".



so if you combine the two, you have like three things:

- subdirectory (mount point)
- key to use for database lookup
- entry in the list of shares

but you can only solve it if you differentiate between "lookup=20
operation" and "element of a list".

a lookup operation may /return/ a list, which is why I said:

"diskstation" (hostname) is a key
list of shares is the result of that lookup operation based on that key
entry is an element of that list you can mount.

This applies to a form of browse scenario. If you have invisible=20
mounpoint, you get:

"diskstation" (hostname) is a key that is going to be a direct=20
subdirectory
the list of shares it returns is going to be a subdirectory list to tha=
t=20
first subdirectory
this will contain the actual shares, so you get top/key/entries.

And you see we basically have the same thing except that this is one=20
level deeper in our hierarchy.

In my desired use case, you get:

top/entry

But in the current implementation of e.g. smb.auto, you get:

top/key/entry

So it is clear diskstation (hostname) IS a key, except that in the=20
current case or scenario this key is ALSO used as the direct descendent=
=20
of the toplevel directory used for the configuration in auto.master.

Which gives rise to the idea that maybe "key" and "subdirectory mount=20
point" should not be equivalent or identical. Not necessarily identical=
=2E


In fact, smb.auto DOES produce a browsable list. It is just /beneath/=20
the subdirectory for its "key" (the hostname) and mounts ALL of the=20
shares at once.

So you now already have that mountstorm (it just gets mounted by=20
default) it's just a level deeper.

You now don't have a mountstorm on the level of hosts, but you have a=20
mountstorm on the level of shares (per host) but it is still the same=20
thing.

So the design specifies that keys must become mountpoints in the=20
"sub-top-level" directory (the directory managed by autofs for indirect=
=20
mounts).

Whereas perhaps conceptually you would need to differentiate between=20
key, and an entry used for mounting, and the difference is that this=20
entry used for mounting can be an element of the list returned by the=20
key.

So you get key -> list -> entries. In the case of current auto.smb, wha=
t=20
happens is:

key -> (subdirectory) -> list (itself an entry) -> entries.

Or in other words:

key -> list -> entries, but mounted beneath top/key, as key is used as=20
an extra directory in between.

Current auto.smb:

  <managed mount point>   /    <key>   /   entries  / contents of share=
s

My preference:

  <managed mount point>   /    entries     /   contents of shares

And why? Only because I want to specify mount points for specific hosts=
=20
manually.



So the question becomes how you can combine such things.


The requirement becomes for the script to return the mount point. A=20
static list does return mount points. A script does not, the mount poin=
t=20
is specified as the "key" given to it. So if you want the script to=20
determine the mount point the way a static list does, you need it to=20
return, in essence, a static list.

Even if your static list is not browseable, so too can a returned=20
"dynamic list" also be not browseable. But at this point your script ca=
n=20
return a mount point of its own. That is again problematic if the key i=
s=20
derived from filesystem access.

So you see how hard this is to reconcile.

If we insist in accessing hidden shares and deriving keys from user=20
action or filesystem action, or filesystem access, then keys are=20
predetermined the moment the system is actually called. The script or=20
database can only return whether something is gonna be there or not.

Then the only way to reconcile it is (in my case) for the key to be not=
=20
the only argument to the script, but I give the script my argument I=20
define in auto.master:

/cifs   /etc/auto.smb   diskstation

Now my script knows that e.g. $1 is gonna be the filesystem requested=20
path, and $2 is gonna be the custom parameter I determined in advance.

I don't need to use the key by itself ($1) to do the lookup. My real ke=
y=20
is $2. But I will use the second key ($1) to return a share for the hos=
t=20
determined by the first key ($2).

In essence what happens with auto.smb is that the key ($1) is used as=20
the host (first key) and smb.auto will itself derive and load the list=20
of shares, and then instantly mount that (it retrieves all of the secon=
d=20
keys and instantly uses that and mounts everything).

autofs allows for this second list of keys to be instantly used and=20
utilized.

But it's not the common use case because you are now fixed to that=20
location the user accesses and of course you could use that location=20
(the key) ($1) to look up a host in a different way, that is perfectly=20
possible. If your script marries "diskstation" to "ds" or "ds" to=20
"diskstation" then you could automount /cifs/ds and it would request=20
shares from host "diskstation".

But you're still stuck with that intermediate level, that extra level o=
f=20
subdirectories.

It's not possible currently to use the "first key" to determine the hos=
t=20
and then get the "second keys" ($1) to determine the entries. Well,=20
actually it is, but not in a browseable fashion:

/cifs   /etc/auto.smb   -Dhost=3Ddiskstation


I believe this could work. You pass your real "primary" key as that=20
variable, and your script returns shares based on that key, but with th=
e=20
"filesystem key" ($1) as the name of the share to return.

Still, rather convoluted at this point, and not possible to browse this=
=20
list.

Because it doesn't return a list. Using $2 to pass that variable=20
wouldn't really be different.

But the script is only called when an entry is accessed (through the=20
filesystem) and as such is never called without a secondary key.

The current auto.smb doesn't have secondary keys, it loads and mounts=20
all of them instantly and automatically, and there is no "automount" fo=
r=20
the secondary level.

Well, there is, it just mounts all of it in one go.

So how do you skip the intermediate level?

- call the script on purpose to generate a 'static list' instead of jus=
t=20
for entries alone.

- use the static list to precreate directories (mount points), or

- use the static list to return readdir information, or to filter=20
requests for directories, or don't use the static list at all and just=20
keep it the same.


So we also see here that the static list *could* be used for the thing=20
you described above, that alternative readdir implementation.

Although it's a bit of a hack, I'm sure.

You could specify some interval for invalidating the list. At which=20
point it is renewed by another "get list" call to the script.


So in essence I am really advocating "return list" functionality for=20
scripts here.

And there is no easy way to implement that while staying compatible wit=
h=20
current scripts because you would need to: call the script with an empt=
y=20
parameter (that will never return an entry) or with a wildcard (that=20
will probably never return an entry) and in essence, that might just as=
=20
well mean, that if you want to take this approach:

- use the wildcard as the "list" operation, scripts that do not know=20
about the wildcard will simply return zero entries.
- use the extra parameter as $2, in other words: allow for additional=20
parameters in auto.master in that form of:

/cifs   /etc/auto.smb   diskstation random

But there are already recognised options. So what we have today (-D) I=20
guess already works, it is just a bit obscure, and it seems to be the=20
equivalent of what you would do.

Then an alternative auto.smb (I called it auto-short.smb) would:

- be called as:

/cifs   /etc/auto.smb   -Dhost=3Ddiskstation

- return a list of shares when called with "host=3Ddiskstation=20
/etc/auto.smb *"
- alternatively you could have it be called with: "/etc/auto.smb *=20
diskstation"

- make sure the shell doesn't expand that * ;-).

- autofs calls this list operation each time auto.master is reread.

- autofs calls this list operation each time some invalidation timeout=20
occurs

- not really any other way to trigger it.

- the static list being returned (really a dynamic list now) can be use=
d=20
for readdir, or even access filtering (it contains all the valid keys).


Now when you have something like this, you can:

- call the filesystem component you use to access the actual shares, th=
e=20
"entry" or simply "share" or "directory". But "key" becomes more=20
comprehensible now as well. "key" now corresponds to "entries in the=20
returned list". Each "entry in the returned list" is now a "mapping=20
between key (directory) and value (device-path). I realize "mount point=
"=20
might confuse with the mountpoint defined in the master file.

"submount" would be ugly. "subdir" is most convenient. "subkey" is=20
illustrative. "entry" describes the entire thing, not just the key. But=
=20
in essence we are just talking about a mount-point here.

Nevertheless in principle the "first key" given should not even need to=
=20
be the mount point in fact. It is a key to a lookup-table.

If you wanted to do it right I think you would need to do away with=20
hidden (or principally unknown) mount points, and basically always work=
=20
with static lists (or dynamically returned lists) and/or give every=20
script a first parameter $1 that is a key that you actually use for it.

Then the second paramter $2 would be the key that the filesystem has=20
actually given you for accessing a path.

In this way "access path" becomes secondary.

Perhaps a script in this way still cannot control the mount point (name=
)=20
but at least now it provides it in advance. Of course there are=20
situations in which you cannot know it in advance or in which it is=20
irrelevant to know it in advance.

You can imagine a list to be much too big to actually retrieve it. In=20
itself a sign of a bad system, I think. If it was that big, you would=20
need hierarchy to make it smaller.

So I don't know if there is ever any real need for obscurity, and for=20
hosts to be accessed while not being able to list them in advance.

I conjecture that this use case in itself would be odd, that you create=
=20
auto-mounts for an unspecified number of hosts you don't really know=20
about in advance.

It makes for zero-configuration, true. You don't have to keep a list=20
anywhere or even arrange for it to be generated.

On the other hand if a list could not be had, the script would just=20
return nothing and the daemon will assume no-browse=20
no-information-in-advance lookups the way it does today.

Basically if you keep the current $1 and use it to pass a wildcard, no=20
script is likely to ever break on that (it will just return nothing).=20
Then $2 can be your primary key. Not every script needs it.

But complete zero-configuration is to me an odd thing: a magical=20
directory that will mount every host given to it including all of its=20
shares, does not seem sensible to me in the sense that you would at=20
/least/ want some configuration for every system right?

One size fits all: the same system for every computer, just place it=20
somewhere in your filesystem and you have access to everything and=20
everything.

No, normally you would want to tailor it because you do not have access=
=20
to an infinite amount of hosts and the /cifs/host/share structure=20
therefore makes not much sense.

/device/share may make more sense, perhaps added with
/hosts/hosts-meeting-a-certain-pattern/share

You already have a pretty big system if you use the latter. Anyway.

I think I should conclude this :p.



What seems sensible to me at least is to add something that doesn't=20
break compability by using a wildcard * for scripts that will return a=20
certain format of list (or just all shares it can find in the regular=20
format) with a $2 parameter designating something such as a "host" or=20
perhaps even "department".

In this way you solve the issue that the current auto.smb requires the=20
"hostname" to be first key given to it because there is no other way to=
=20
pass a key. Then the actual keys can be passed as "second parameter" in=
=20
this sense that they still become $1, but at least now you can specify=20
your host to it in advance instead of guessing it on the wind ;-).

So if I have to say anything I would say that I recommend this=20
structure:

- $1 remains the filesystem key
- $2 becomes the additional key a user may specify in auto.master
- $1 as * will designate the request for a list lookup
- the list can in the future be used for readdir implementation, and=20
currently for precreated mountpoints in case "browse" is used.





>> indicate that this is true for "no browse" on "static maps" as well,=
=20
>> and
>> that directories are only created when they are accessed.
>=20
> That seems to be missing from the man page.
>=20
>> And that no-browse is the configured default.
>=20
> Not sure about that either.
>=20
> This (from auto.master(5)) says that I have made "browse" the interna=
l=20
> program
> default way back when version 5 was first developed but I install a
> configuration that turns it off because of (because of the above=20
> problems, which
> are not spelled out in the man page):
>=20
>      [no]browse
>             This is an autofs specific option that is a pseudo mount
>             option and so is given without a leading dash. Use of the
>             browse option pre-creates mount point directories for
>             indirect mount maps so the map keys can be seen in a
>             directory listing without being mounted. Use of this
>             option can cause  performance problem if the indirect
>             map is large so it should be used with caution. The
>             internal program default is to enable browse mode for
>             indirect mounts but the default installed configuration
>             overrides this by setting BROWSE_MODE to "no" because
>             of the potential performance problem.

I know, but if you, as a user, do not understand what the hell it is=20
doing in the first place, and you have no time for extensive manual=20
reading in advance (like me) you will never get to that option because=20
you still don't understand the basics, and the more advanced stuff (lik=
e=20
that) that will be too hard to understand.

That information is too difficult to comprehend (or digest) when you ar=
e=20
someone who still doesn't understand how it works.



>> I think that limitation indicates why using relative paths is so muc=
h
>> more pleasant. A map file using relative files can be "moved around"=
=2E=20
>> A
>> map file using absolute paths cannot.
>>=20
>> Could you not make a direct map out of the key of the master file, a=
nd
>> the keys of the sub-maps?
>=20
> Can't really do that.

It's not that I saw it as necessary, I just still think the difference=20
and distinction between "direct" and "indirect" is rather I dunno, weir=
d=20
I guess ;-).



> The closest thing to that would be multi-mount map entries, again fro=
m
> autofs(5):
>=20
>    Multiple Mounts
>        A multi-mount map can be used to name multiple filesystems
>        to mount. It takes the form:
>=20
>        key [ -options ] \
>            [[/] location \
>           [/relative-mount-point [ -options ] location...]...
>=20
>        This may extend over multiple lines, quoting the line-breaks=20
> with
>        `\=C2=B4.  If present, the per-mountpoint mount-options are ap=
pended
>        to the default mount-options. This behaviour may be overridden
>        by the append_options configuration setting.

Something I am already using (almost) and I believe this is what=20
auto.smb uses by default too. It's just that I use it to mount parts of=
=20
the same share. (Samba smbd often has issues with file-system boundarie=
s=20
so I create a share out of each filesystem and share them individually,=
=20
then mount them as above).



>>=20
>> normally ( /bla/bla ) indicates an absolute path and can only be use=
d=20
>> in
>> a direct map, from what I've seen. You *could* cause it to turn this
>> "indirect map" into a direct one.
>>=20
>> ie. ( bla/bla ) =3D=3D indirect
>>      ( /bla/bla ) =3D=3D direct.
>=20
> In the Sun map format maps indirect mount map keys are a single path=20
> component
> only.
>=20
> The situation is different if using amd format maps but I could work=20
> out how
> direct mount maps could be usefully used so that mount type has not=20
> been
> implemented. Even on Solaris where they are supposed to be fully=20
> supported I
> could make sense of them.
>=20



>> /start/of/the/-  ( path )
>>=20
>> Then any path in the master file ending with /- would be a direct=20
>> path.
>>=20
>> And would cause the (static) map file to be treated as direct.
>=20
> Nope, that is unlikely to work and would lead to a lot of problems.
>=20
> One example might be with:
>=20
> /start/of/the/-/path
>=20
> people will ask where have the directories below /start/of/the/ gone=20
> and the
> answer will be they have been covered by the autofs file system mount=
=2E

But that's no different from a regular mount on that location.


> Next it would be but I should be able to see these, surely that's eas=
y=20
> to fix.
>=20
> At hat point I would probably leave the conversation.

:-). Haha. But come on, you can't take that seriously, the same thing=20
happens with a regular mount, even a bind mount does that. It's=20
absolutely not possible to reveal the contents of some subtree when=20
another filesystem had mounted on top of it, except by remounting the=20
entire subtree elsewhere.

(I am trying out some gimmick that requires me to mount the root device=
=20
under something like /run/mount/rootfsclone, because I am bind mounting=
=20
on top of something that I still want to be accessible. The only way to=
=20
make it accessible is to mount the entire rootfs somewhere else. I=20
basically need a persistent location for individual devices without=20
anything mounted on top of them; ie. a pure one-file-system mount tree.

Then you have those individual mount-trees (filesystem trees) and THEN=20
you have the complete FHS that you normally use.

That seems like the only sensible way to approach a lot of issues.=20
Having a /mounts/ with every (custom) mounted device present there.

Recently the number of incomprensible mounts reported by "mount" has=20
grown so big that the entire tool has become unusable, mostly due to=20
cgroups. And tmpfs's, and debugfs's, and what not.

I now find I need to create a wrapper for mount so that "mount" stays a=
t=20
least usable to the user. Such that every subdirectory of /sys, and=20
every subdirectory of /run, and every subdirectory of /dev/, is actuall=
y=20
hidden from display. And from /proc as well. And the same applies to DF=
=2E

(I really need to find a way to better save and redistribute these=20
modifications).






>=20
> In any case a similar thing, but more explicit and I think easier to=20
> follow and
> maintain are the autofs multi-mount map entries, what I think you=20
> called
> relative path above.
>=20
> It isn't clear but that syntax should function within both direct and=
=20
> indirect
> mount maps.
>=20
> The problem with all this is that substitution cannot be used in the=20
> key.
>=20
> The reason for that is same as why the amd regex key matching has not=
=20
> been
> implemented.
>=20
> A linear map scan would be needed for every lookup in order to match=20
> what has
> been sent to us from the kernel. And as much as you might feel that=20
> wouldn't be
> a problem because maps are generally small I can assure you it would=20
> make life
> really unpleasant for me!

:). You have lost of enemies; if you don't do things right :P. LOL.

I am not thinking about this now, but I guess you mean that my proposed=
=20
solution of saving those static lists (or dynamic lists) would actually=
=20
help this :p.

Actually what you are saying is that even doing lookups on those lists =
I=20
proposed would be quite annoying.

However currently this lookup is already done on the server (if it is=20
some database) or in the static map (if they are not browseable). Right=
?

Databases are generally better at lookup than small-scale applications.=
=20
Now you need hash-tables etc. Anyway, I can't think about it right now.



>> I only noticed just now because autofs(8) references autofs(5), and=20
>> I'm
>> like ....huh?
>=20
> Yeah, that's what we have ....




>> /media/*/nas    /etc/nas-shares.map
>=20
> Can't do that, each /media/*/nas needs to be mounted at program start=
=20
> so that
> automounts can be done?

Actually the shell easily expands such a pattern to all matching trees?

e.g. if you create /usr/local/doc, and then do

"ls /usr/*/doc/" you will get the output of:

/usr/local/doc  /usr/share/doc

So with that output, you mount all of them, all the while knowing that=20
the middle component (here) is a wildcard. Then the daemon knows about=20
this wildcard and can use it while processing /etc/nas-shares.map for=20
each of them; but they are all individual mounts at that point.

e.g.  /media/me/nas and /media/pamela/nas are now individual autofs=20
mounts.

but their "/etc/nas-shares.map" is called with a different wildcard.


I mean that either /media/me/nas will already exist (precreated by the=20
user) or your program creates it (I think it already does that).

Actually it cannot create it DUH, so the user will need to precreate=20
them.


I know /media is usually seen as a managed directory but this is=20
annoying in the first place. Such an important name (/media) and I=20
cannot do anything with it because it is already taken. At the same tim=
e=20
accessing it from your home directory is usually quite annoying. So in=20
order to make sense of it I must precreate /media/xen and=20
/media/dannielle and prevent the daemon (that /media thing) from wiping=
=20
them.... buh.

The funny thing is that /media/xen is not even owned by xen.

The subfolders are, but the thing itself isn't (how stupid?).

So in this case perhaps not as convenient, but in the general case if I=
=20
precreate:

/mytree/me/nas
/mytree/quinty/nas

etc.

Then the daemon could read

/mytree/*/nas

on program start and see all the shares that match. All the directories=
=20
that match.

Then it knows that "me" and "quinty" are wildcard entries for their=20
respective mounts.




>>=20
>>=20
>>=20
>>=20
>> > By definition a program map can't know what keys may be passed to =
it.
>> > And, yes, even autofs(5) doesn't say explicitly that a program map
>> > doesn't know
>> > what keys may be passed to it, perhaps that should be ammended.
>>=20
>> In principle even a program map could read all of the available keys
>> from whatever database it consults, and return all of them; or retur=
n
>> something only (as it does now, perhaps) when a given key matches (i=
s
>> found).
>=20
> I've thought of that too.
>=20
> But I've resisted because I'm concerned about confusing existing=20
> program maps
> people have in unpleasant ways.

At some point you need to be willing to break previous compability.

I understand that Linux is usually a running-upgrade system and even if=
=20
people do upgrade entire distributions they want the system to keep=20
functioning as normal without changing anything.

But e.g. the Debian update program can tell you stuff like "This packag=
e=20
does something different now, and you need to ensure it can either=20
handle or ignore the wildcard".

on every package installation.



> That's not a bad thought, but what would $1 be so that older scripts=20
> wouldn't
> choke on it.

I had suggested * because there is no hostname called *.

But scripts may very well mount local filesystems as well. And they=20
might very well use a shell to do stuff like "[ -d $key ]" or "[ -d=20
"$key" ]" and....

And as always, stuff breaks a lot when people don't use "$key". If=20
people's scripts are badly written then [ -d $key ] will malfunction.

In order to cover that you would have to use something like "_", no one=
=20
is going to use _ as an actual filename.





>=20
>>=20
>> So, for instance, if $2 is "browse" the script may choose to return =
a
>> browse map, or list of shares, with whatever options are available (=
it
>> could even return the UID/USER of the share given options, so that t=
he
>> created directory would have the same UID as the to be mounted share=
!)
>> -- meaning it might simply return ALL entries it could possibly retu=
rn
>> in the default format, which is the meaning of the wildcard, and the
>> program (autofs daemon or module(?)) would be able to generate the
>> appropriate directory entries based on that. So in that case you're
>> probably going to be rid of the problem of the non-matching state of
>> pre- and post-mount of directories.
>=20
> which pretty much defeats the only possible solution I can think of f=
or=20
> "browse"
> option mounts ...

You mean the one suggested above. But if you make an alternative readdi=
r=20
having a list available won't bug you right?

I mean, having mount information available in advance cannot be a=20
problem, only a help.




> Like I said, I wanted to have the default as "browse" but got hit wit=
h=20
> too many
> complaints and was only willing to change the package installed defau=
lt
> configuration to satisfy them.
>=20
> I'm not going to try that again.

"Design by committee" they call it ;-).

Someone told me that OpenSUSE has had "browse" as the default for at=20
least 5 years.

You did think about making a distinction between static and LDAP/NIS=20
maps? I'm not sure I am not crossing my bounds here now ;-). Seeing tha=
t=20
I already suggested it.





>> In this way no one can ever get confused, so you might just rename
>> autofs(5) to autofs.map(5).
>=20
> Yeah maybe ...
>=20

>> I will look into providing a patch, but I hope you can rename=20
>> autofs(5)
>> to autofs.map(5) before doing anything like that. I don't feel like
>> improving a system I know myself haven't had access to, in that sens=
e.=20
>> I
>> don't mean you have to do that straight away, but if that is a=20
>> possible
>> direction to go, or change to make, then I could supply a patch or
>> anything based on the system that would result from that, seeing tha=
t
>> autofs(5) is already pretty good in that sense.
>=20
> At some point I'll need to return to this and make a list.
> Unfortunately that time isn't now.


Here is just my short summarize:


- suggested compromise between browse and nobrowse by only making brows=
e=20
for static lists the default to please new people unaware of what will=20
happen

- suggested perhaps using _ as the wildcard key, not using that "browse=
"=20
flag as $2, but allowing a different "primary" key as $2 if the script=20
wants it.

- suggested changing autofs(5) to autofs.map(5) such that users will be=
=20
able to find it.

And the rest is up to you, I think you don't need anyone rewriting it=20
for you now, but I could still try my hand if that was necessary. I jus=
t=20
think using better terminology is dependent on the first two suggestion=
s=20
here, particularly perhaps the second, and otherwise you'll have to=20
explain current terminology better and create some way to separate "key=
"=20
in auto.master from "key" in "autofs.map" ;-).

However if scripts could accept an additional "key" and the default=20
operation or capability would for them to be able to return a "list"=20
then it would become more clear that the additional "key" would be the=20
index to retrieve that list, and that the entries resulting from that=20
may have their own "keys" but these "keys" are then used for the=20
individual "mount points".

So then you have reason to call the entry keys "entry keys" and the=20
other ones "lookup keys" for instance. Then, static maps use "entry=20
keys" but scripts have "lookup keys" as their 2nd parameter. The script=
=20
then has "entry key" as the first, and "lookup key" as the second=20
parameter. Then, entry key is equivalent to subdirectory, and lookup ke=
y=20
is often going to be equivalent to e.g. hostname.

A script without list functionality only accepts "entry keys" but may=20
very well use them as lookup keys as well.

A database also uses them as equivalent. But at least now you have=20
something of a model to conceptually separate them. Since browse alread=
y=20
functions for e.g. LDAP, in many cases you will not use a lookup key fo=
r=20
that, simply because (a) /etc/autofs_ldap_auth.conf already contains=20
such paramters and (b) the other parameters are specified in the=20
mapname-format for LDAP.

So what we call "lookup key" would already be encoded in the LDAP URL=20
but such a thing is not possible for scripts.

So you could call scripts the exception to the rule in not having this.=
=20
Of course it exists,: the "-D" parameters.

(I think? Haven't tested it yet).

So I don't know.




=46or a database the entry key is always going to be a lookup key to th=
e=20
database.
Entry keys can also result from a list fetch.

So they can result from filesystem access or from some list retrieval.

But if "browse" becomes more normal and standard, you would see that it=
=20
becomes easier to talk about this "entries from the list you get when=20
quering the database/script for it".

Then the gap between "entries from the list" and "subdirectories=20
created" is smaller than the gap between "filesystem access" and=20
"subdirectories created".

Meaning: key (database designator) -> list -> entries (database entries=
)=20
is conceptually easier to grasp than key (filesystem access) -> entry=20
(database entry).

Or key (filesystem access) -> database lookup -> entry.

Simply because it is hard to understand that user action (filesystem=20
lookup) is the input to the entire system and is actually the keys bein=
g=20
used.

Even if it's not always to be used, having a level in between that ties=
=20
"key" to "pre-existing shares" or "pre-existing entries" becomes easier=
=2E=20
When a user thinks of "key" they think about either existing shares or=20
existing hosts.

Then conceptually it is logical to assume that the script or database=20
can give back this list. And that either this list is precreated on the=
=20
harddrive, or at least that it is used to match the "keys" against, for=
=20
instance.

(By harddrive I mean filesystem (hierarchy)).

This is why I think standard operation for at least smaller lists shoul=
d=20
be a form of browse or at least a form of list retrieval, if you are=20
going to have dynamically generated lists in any case.

Then, it conforms more to a sense of what a general computer user is=20
going to have of the idea of auto-mounting mount-points. It (he/she)=20
thinks those mount-points are already going to exist, prior to being=20
automounted.

This in turn makes it easier to explain that the key is really a=20
subdirectory, and that there can be another key if needed to specify th=
e=20
host, or something of the kind.

Then, the most common use case for a new or general computer user=20
wanting to try this is going to be met, because that use case is going=20
to involve auto-mounting network-shares of which there is a limited=20
number.

And it will involve something like

/nas/media
/nas/backup
/nas/home

etc.

Now I'm not sure if it covers the entire use. But at least you'd also=20
have a script that can generate a static map for you that you can then=20
use in place of the scripts, if you want to prune the mounts that are=20
actually visible to you.

Apart from the distributions themselves there is not really any softwar=
e=20
in the Linux world that is tailored to either the desktop user, or the=20
server user, but not both, is there?

Apart from the desktop environments.

Anyway this was a long read and write, I guess, for both of us :P.

Time to get some food again or at least some water :p.

See ya.











--
To unsubscribe from this list: send the line "unsubscribe autofs" in
