From: Ian Kent <raven@themaw.net>
Subject: Re: newly added heirarchical mount points not found
Date: Wed, 25 Feb 2004 12:09:35 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402251203060.31545@wombat.indigo.net.au>
References: <1077211015.19371.32.camel@brilong-lnx2.cisco.com> 
	<1077211301.19371.34.camel@brilong-lnx2.cisco.com> 
	<Pine.LNX.4.58.0402202058120.4573@raven.themaw.net>
	<1077284694.21595.54.camel@brilong-lnx2.cisco.com>
	<403AA2A7.3010409@motorola.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <403AA2A7.3010409@motorola.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Georgoulias <tom.georgoulias@motorola.com>
Cc: autofs@linux.kernel.org

On Mon, 23 Feb 2004, Tom Georgoulias wrote:

> Hi:
> 
> I'd like to know if the heirarchical mount point behavior I've been 
> seeing lately with autofs4 is what I should expect.  When I add an 
> additional submount point to an existing set of heirarchical mounts, I 
> cannot access the file system referenced by the new mount point.
> 
> The systems I am seeing this behavior on are Red Hat 8.0 and 7.3 systems 
> with the 2.4.20-28.8bigmem and 2.4.20-28.7bigmem kernels (and the 
> autofs4 module it contains) and autofs-4.1.0-2.
> 
> I have a set of entries in one of my NIS automount maps very similar to 
> these:  (names changed to protect the innocent. ;)
> 
> in automount map auto.stuff
> --
> top \
> /key2 bender:/vol_A/key2 \
> /key3 fry:/vol_B/key3 \
> /key4 fry:/vol_B/key4
> --
> Using "cd /stuff/top/key3" works just fine from both my linux and 
> solaris systems.
> 
> However, if I add an entry for key9:
> --
> top \
> /key2 bender:/vol_A/key2 \
> /key3 fry:/vol_B/key3 \
> /key9 mom:/vol_B/key9 \
> /key4 fry:/vol_B/key4
> --
> and push out the updated map, a "cd /stuff/top/key9" only works on 
> Solaris.  The linux systems see the new entry via "ypmatch -k top 

Strange. I thought you would at least have to run 'automount' to refresh 
the maps on Solaris.

> auto.stuff", but I get a "No such file or directory" error when I try to 
> cd into it.  Today I tried testing this with the 

That's right because, for file, NIS and LDAP maps, the daemon uses a cache 
that is not aware of updates.

In 4.1.0 you can send a HUP signal to the daemon process controling the 
map to ask it to update the map in similar fashion to running automount on 
Solaris.

> autofs4-2.4-module-20031201, just to see if it helped, but the problem 
> still remains.  According to the README file the new module only 
> provides ghosting, but I figured I didn't have a lot to lose by testing 
> it anyway.

Browsable mount points are a must. 

Anyway try the HUP signal.

Ian
