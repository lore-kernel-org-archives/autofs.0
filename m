From: Ian Kent <raven@themaw.net>
Subject: Re: bind mounting into a generated multi-level
	directory	structure
Date: Mon, 11 Feb 2008 19:34:26 +0900
Message-ID: <1202726066.24318.35.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0802090220120.18112@potato.cts.ucla.edu>
	<1202717629.24318.11.camel@raven.themaw.net>
	<Pine.LNX.4.64.0802110125580.18112@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802110125580.18112@potato.cts.ucla.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: autofs@linux.kernel.org


On Mon, 2008-02-11 at 01:53 -0800, Chris Stromsoe wrote:
> On Mon, 11 Feb 2008, Ian Kent wrote:
> > On Sun, 2008-02-10 at 00:29 -0800, Chris Stromsoe wrote:
> >
> >> I have a set of directories that are created and removed 
> >> programmatically, and are hashed three levels deep 
> >> (/top/hash/hash/name).  The depth is constant, the hashes and names are 
> >> not.  There are around 35k at any time. I would like to bind mount a 
> >> common directory into each top-level (/top/hash/hash/name/data) on 
> >> demand.
> >
> > I'm not clear on what you mean by "top"?
> 
> "/top" is the root of my directory tree.  I have roughly 35k directories 
> that are stored as /top/hash1/hash2/name, where hash1 is one hash of 
> "name" and hash2 is a different hash of "name".  Beneath "name" there are 
> a variety of other files and directories.  New "name" directories are 
> hashed, created, and populated on the fly.
> 
> I would like to bind mount a common directory onto 
> /top/hash1/hash2/name/data, so that I can chroot into .../name/ and run 
> common code, minimizing exposure to the rest of the system.  I would like 
> to use autofs if possible, so that I don't have to copy 20Mb+ of data 35k 
> times or maintain 35k bind mounts or do something else that continously 
> uses resources.
> 
> I also don't want to have to edit auto.master every time I add or remove a 
> "name" directory, or have to maintain 35k entries in a flat file.
> 
> >> Can I use autofs to do that without having to explicitly list all of 
> >> the directory paths in auto.master?
> >
> > What version of autofs are you using?
> 
> I've been playing with 4.1.4, from Debian stable, but am more than willing 
> to use 5.0.3 if it will do what I need.
> 
> Playing around so far, the best I've been able to come up with is doing a 
> bind mount of /top/hash1/hash2/name to a simpler /mnt/name (using a 
> program map to compute the hashes), then hopfully submounting the "/data" 
> directory, but I haven't been able to figure out how to get /mnt/name/data 
> mounted.  Can you do submounts of a program map?

So let me see if I've got this yet.

You're happy to use a program map to generate the hash
directory, /top/hash1/hash2/name on something like /mnt/name.

You need to be able to submount path /top/hash1/hash2/name/data onto
something like /mnt/name/data.

> 
> My auto.master is:
> 
> /mnt	/etc/auto.mnt
> 
> And /etc/auto.mnt is (I'm using bogus "hash" values for test purposes):
> 
> #!/usr/bin/perl
> my $f = lc shift @ARGV;
> my $d = sprintf "/top/a/a/%s", $f;
> exit 1 if ! -d $d;
> printf ":%s\n", $d;

So if my reading is correct then you probably need to generate a mount
string from the program map that looks something like (I haven't had to
work with macro defines for a while so the syntax might not be quite
right):

-fstype=autofs -Dhash1=$h1 -Dhash2=$h2 -Dname=$f /etc/auto.submount

In the above the $h1, $h2 and $f need to be substituted with the values
computed by the script, probably using something like you're printf
above.

The /etc/auto.submount would be something like:

*	:/top/$(hash1}/$hash2}/${name}/data

or if "data" was actually the key

*	:/top/$(hash1}/$hash2}/${name}/&

Other thoughts.

I can't be sure this will work so you'll need to try it out and see how
you go.

The $f above in -Dname=$f might be able to be substituted with &, the
value of the key, but that might confuse the autofs macro substitution
code.

I can't remember whether we have to ":" escape the leading "/" of a
submount map, I'm sure you'll work that out fairly quickly though.

There are clearly a number of variations on this but you will need to
work out what is best.

Ian
