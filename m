From: mmarion@qualcomm.com
Subject: Re: autofs not mounting directories
Date: Thu, 18 Mar 2004 18:00:36 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403190200.i2J20at3022279@miguelito.qualcomm.com>
References: <Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On 17 Mar, Ian Kent wrote:

> Sounds like you may be suffering from the same problem that was reported 
> by Michael Blandford. I'm mystified I haven't seen the problem before as 
> it is so fundamental to proper operation.

Reading over this thread, it sounds like it might be related to something we
patched for a long time ago (way before you took over).  Jim Barbour here at
Qualcomm figured out a one line patch that fixed similar issues we were having
with our program map mounted trees.  He sent it to the old list way back in 
early '01 and noone seemed to care then.  

I still have to add this one line in for our direct maps (via program) to
work:

*** autofs-4.1.1-orig/daemon/automount.c	Thu Jan 29 08:01:22 2004
--- autofs-4.1.1/daemon/automount.c	Fri Mar  5 12:57:47 2004
***************
*** 1066,1071 ****
--- 1066,1072 ----
  			close(ap.ioctlfd);
  			close(ap.state_pipe[0]);
  			close(ap.state_pipe[1]);
+ 			chdir(ap.path);
  
  			err = ap.lookup->lookup_mount(ap.path,
  						      pkt->name, pkt->len,

This is the pre-release 4.1.1 btw.. in case it's slightly different in the
official 4.1.1.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Alcohol and Calculus don't mix. Never drink and derive.
==> Another /. gem
