From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Seeing autofs-5.0.2 core dumping
Date: Fri, 21 Dec 2007 13:13:00 -0800
Message-ID: <20071221211259.GC29941@cornholio.qualcomm.com>
References: <20071221023024.GB10904@cornholio.qualcomm.com>
	<1198236856.3488.11.camel@raven.themaw.net>
	<20071221192744.GA14860@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071221192744.GA14860@cornholio.qualcomm.com>
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
To: autofs@linux.kernel.org

On Fri, Dec 21, 2007 at 11:27:45AM -0800, Mike Marion wrote:

> ago.  Changed in that the local path is different, but the mount point
> (server:/path) is the same.  So we're going to try to re-create this on
> a host by hand to see if it has to do with the daemon seeing a change in
> what it has cached vs what the maps now answer with.

Even weirder... I built a new box in our lab to use for testing and
found that a small subset of paths didn't get loaded in the initial
startup.. but when the default 10min timeout happened, they were then
added.  That subset exactly matches the subset we're seeing the bug
with.  Nothing obvious in verbose output as to why it didn't load those
paths initially.

Setting up a debug log and going to strace daemon at same time.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
SCSI is *NOT* magic. There are *fundamental technical reasons* why it is
necessary to sacrifice a young goat to your SCSI chain now and then.
