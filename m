From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Re: mount fails because entry in multi-mount doesn't work
Date: Thu, 13 May 2004 10:59:14 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1084471154.8589.18.camel@bad.jf.intel.com>
References: <40A38585.4050103@freescale.com>
	 <Pine.LNX.4.58.0405132305230.13693@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405132305230.13693@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 2004-05-13 at 08:08, raven@themaw.net wrote:
> On Thu, 13 May 2004, Tom Georgoulias wrote:
> 
> > Yesterday I ran into an issue where a mount point wasn't working and 
> > tracked it down to one of the submounts.  From what I can tell, if one 
> > of the submounts in a multi-mount doesn't work, the entire mount point 
> > won't work.  If that is the case, can this behavior be changed?
> 
> Use the -nonstrict option on the autofs mount.
> 
> OK this has happened one to many times. I think I'm going to change this 
> default.
> 
> What do people think about this idea?

Yes, please!  I have been asking for this default for years.

Forrest
