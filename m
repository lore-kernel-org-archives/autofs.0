From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: unacceptable bug in autofs kernel module
Date: Tue, 8 Mar 2005 14:53:49 -0800
Message-ID: <719dea83a19179ae2752ed3375139371@qualcomm.com>
References: <C147DE5CF1A13D42B560879D6D212E63012F3B5D@us-bv-m21.global.tektronix.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Transfer-Encoding: 7bit
In-Reply-To: <C147DE5CF1A13D42B560879D6D212E63012F3B5D@us-bv-m21.global.tektronix.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

On Mar 7, 2005, at 4:16 PM, peter.a.harris@exgate.tek.com wrote:

> We use a mixture of direct and indirect maps, all with ghosting turned 
> on.
> The problems we are seeing are evenly spread between the two types.  
> Our
> basic tools and home directories are indirect maps, the project data 
> and
> project specific tools are in a large direct map.  All the maps are 
> NIS (not
> NIS+) served.  All totaled we have about 1200+ mounts.

Sounds close to us in size, though we had to move our map into a file 
ages ago... we broke NIS at some point.  A quick check shows more 3000+ 
mounts, but still 1200 is a lot.  We've been using program maps so far 
though on linux, and haven't seen any of the same "the file isn't 
there.. even though it's there" issue on solaris at all.

> We have also seen some problems on the Solaris boxes in a timeframe 
> similar
> to our Linux problems.  We have been getting more RPC timeouts and NFS
> server not responding errors in the messages files.  And the users 
> have been
> complaining of, what they have termed, "pausenia" and "stuttering".
> Pausenia is where the user types a command and the shell locks for 15 
> to 60
> seconds before anything happens.  Stuttering is a file not found error,
> followed by the file being there when the user immediately (after 
> cursing
> and retyping) reissues the command.  The one difference we see on the
> Solaris side is that the automounter seems to self-recover.

Is the pausenia on solaris happening near the top of the hour?  We've 
had a similar problem that seems to occur when automount on solaris 
does it's hourly check/flush where it parses the maps again.  We 
noticed when that happens that automount takes up a lot of CPU too.

We don't see the stuttering so much since it only seems to occur when a 
batch lsf job is submitted, and not when the user is working 
interactively.

> We have turned off the "/net" program map because there are too many
> problems with things staying mounted, overly long exports lists from 
> the
> filers, etc. and we don't really need it on every machine.

Ah yes.. that's why I had to write this huge, ugly, shell script that 
scrubs hosts trying to find and flush such hung/gone mounts.   If you 
ever want to see it.. let me know. ;)  I found I could force umount 
most of the hung mounts by spoofing the IP of a missing host on an 
aliased interface, though I had to disable tcp mounts on /net for that 
to work.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Drew: "Violence doesn't solve anything? World War I. World War II. Star 
Wars.
every Super Bowl. Who says violence doesn't solve anything?!" ==> Drew 
Cary Show
