From: Chris Stromsoe <cbs@cts.ucla.edu>
Subject: Re: bind mounting into a generated multi-level directory
 structure
Date: Tue, 12 Feb 2008 14:35:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0802111419170.32418@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0802090220120.18112@potato.cts.ucla.edu> 
	<1202717629.24318.11.camel@raven.themaw.net>
	<Pine.LNX.4.64.0802110125580.18112@potato.cts.ucla.edu>
	<1202726066.24318.35.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1202726066.24318.35.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Mon, 11 Feb 2008, Ian Kent wrote:
> On Mon, 2008-02-11 at 01:53 -0800, Chris Stromsoe wrote:
>
>> Playing around so far, the best I've been able to come up with is doing 
>> a bind mount of /top/hash1/hash2/name to a simpler /mnt/name (using a 
>> program map to compute the hashes), then hopfully submounting the 
>> "/data" directory, but I haven't been able to figure out how to get 
>> /mnt/name/data mounted.  Can you do submounts of a program map?
>
> So let me see if I've got this yet.
>
> You're happy to use a program map to generate the hash directory, 
> /top/hash1/hash2/name on something like /mnt/name.
> You need to be able to submount path /top/hash1/hash2/name/data onto 
> something like /mnt/name/data.
> 
> So if my reading is correct then you probably need to generate a mount 
> string from the program map that looks something like (I haven't had to 
> work with macro defines for a while so the syntax might not be quite 
> right):

Thanks for the pointers.  They got me thinking in a different direction. 
Instead of mounting the data directory into the raw hash directories, I'm 
generating a bind mount on demand, mounting the shared static directory 
onto /opt/chroot/key, then bind mounting the hash directory onto 
/opt/chroot/key/user using multi-mount.

For the archives, in the event anybody else comes looking to do something 
similar, my auto.master is

   /opt/chroot	/etc/auto.chroot


My (cut down) auto.chroot script is:

   #!/usr/bin/perl
   my $f = lc shift @ARGV;
   exit 1 unless &validate($f);

   my ($h1,$h2) = &hash($f);
   my $d = sprintf "/opt/u/%s/%s/%s", $h1, $h2, $f;
   exit 1 unless &check($d);

   printf "-fstype=bind,ro :/opt/dataroot \\\n";
   printf "/user -fstype=bind $dirname\n";

   exit 0;



-Chris
