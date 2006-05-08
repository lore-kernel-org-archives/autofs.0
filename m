From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Umount call getting stuck, hanging nfs?
Date: Mon, 8 May 2006 16:34:38 -0700
Message-ID: <20060508233437.GG9873@cornholio.qualcomm.com>
References: <20060504204141.GO27751@cornholio.qualcomm.com>
	<Pine.LNX.4.64.0605050955571.2898@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605050955571.2898@raven.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Fri, May 05, 2006 at 09:59:14AM +0800, Ian Kent wrote:

> I think that might be the other way around.

You mean rpciod is already hung before the umount, and the umount is
then hung due to the rpciod?

> > /bin/umount //usr/local/projects/dsp/qdsp6
> > 
> > root      6270  0.0  0.0     0    0 ?        D    Apr28   3:17 [rpciod]
> > 
> > unfortunately, once this happens, any new mounts will fail.  Can't even
> > stat the path above via df.  Basically the whole NFS layer is stuck.
> 
> Tell us what the maps look like.

The noted path is like this:
/prj/dsp/qdsp6 -rw,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,rsize=32768,wsize=32768,noquota
western:/vol/eng_aus_0004/qdsp6

And the rest of the file is very similar.  The huge amount of options
came from trial and error with performance problems we were having, and
they're defaulting to tcp mounts.  The odd thing is that we basically
never have mounts hanging off this /prj tree in San Diego, or any other
office except for one.  And it's only hanging when talking to their 2
local NetApp filers.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
A nerd is someone whose life revolves around computers and technology.
A geek is someone whose life revolves around computers and technology... 
and likes it!  - Stolen from a /. post.
