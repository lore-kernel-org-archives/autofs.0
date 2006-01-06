From: Ian Kent <raven@themaw.net>
Subject: Re: is there any progress
Date: Fri, 6 Jan 2006 15:46:36 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0601061533480.21807@wombat.indigo.net.au>
References: <43BD523B.1040705@bppiac.hu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43BD523B.1040705@bppiac.hu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Farkas Levente <lfarkas@bppiac.hu>
Cc: autofs@linux.kernel.org

On Thu, 5 Jan 2006, Farkas Levente wrote:

> hi,
> is there any progress in the "autofs never umounted" area?
> thnaks in advance.

Perhaps.

One of the patches in the group I'll be submitting soon changes the 
way "busyness" is established. The change will consider a mount busy only 
if it has positive reference count such as an actual open file or working 
directory set. I'm changing this to make the busy timeout consistent for 
both existing versions and the direct mount implementation coming in 
version 5.0.

While I can't do much about mounts being triggered by aggressive 
filesystem scanning I hope that this change will also allow these scanned 
type of busy mounts to timeout and umount.

I only have patches for 2.6.15-rc5-mm3 at the moment but I will probably 
need to make a set for 2.6.14 for my own testing.

Ian
