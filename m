From: Ian Kent <raven@themaw.net>
Subject: Re: Laptop users with local home directory
Date: Sat, 27 Feb 2010 11:09:06 +0800
Message-ID: <4B888CD2.2030701@themaw.net>
References: <1220a921002260615h420460f9w9a7b599ce49bfcd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1220a921002260615h420460f9w9a7b599ce49bfcd2@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Robert Lazzurs <rob@lazzurs.net>
Cc: autofs@linux.kernel.org

On 02/26/2010 10:15 PM, Robert Lazzurs wrote:
> Hello,
> 
> I have a number of laptop users that have both a local home directory
> on their laptop and a NFS mounted home directory when they are in the
> office.
> 
> What they want to be able to do is only use the local home directory
> as their current home directory when the NFS server is not available.
> So for example using the replicated syntax I tried something similar
> to the following for a map on /homes/
> 
> username nfsserver:/home/username localhost:/home/username
> 
> The passwd entry would then point the user home directory to /homes/username.
> 
> The issue with this currently is that autofs will always prefer a
> local mount over a network mount, even with weighting.  Is there any
> way to provide this facility in a similar way to the replicated syntax
> without using a script for the map?

The only way to do that is to stop bind mounting for the entry or the
map, depending on what you need. That also means you need to have the
NFS server enabled on the local machine.

There are two ways to do it. One is to use the nosymlink pseudo option
or explicitly specifying the port option for the mount. But beware that
nosymlink option might go away or be renamed at some point in the future
or an additional option which does the same thing introduced and
documented, leaving the nosymlink undocumented, but it's unlikely to be
done any time soon.

Ian
