From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with rpc_ping times, permission denied mounts,
	etc.
Date: Thu, 3 Feb 2005 09:13:37 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502030911110.23477@wombat.indigo.net.au>
References: <4201347A.6000605@redhat.com>
Mime-Version: 1.0
In-Reply-To: <4201347A.6000605@redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 2 Feb 2005, Chris Feist wrote:

> Ian,
> 
> Looking at Sun's documentation it doesn't appear that they take into 
> account ping times when using automounter maps.  It looks like they just 
> sort by network proximity and then weight. Would it make sense to remove 
> the rpc_ping requests and only use network proximity and weight.
> 
> Also, it seems like it would be best to return all of mounts from the 
> get_best_mounts function in order from best to worst.  Then, when it's 
> time to mount the directories we can try the first and if we get 
> permission denied or it isn't there we can fail over to the second, etc. 
>   As opposed to what happens now if the best host has nfs temporarily 
> disabled (or the wrong permissions set) the whole directory fails to mount.
>

Sounds good.

We probably need to assign priorities in some sort of semi-democratic 
way, to these "larger than bug fix" tasks.

Ian
