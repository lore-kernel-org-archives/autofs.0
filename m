From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Re: autofs not unmounting mount points?
Date: Fri, 12 Mar 2004 10:15:12 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1079115312.27266.4.camel@bad.jf.intel.com>
References: <4051DB39.4060905@astro.wisc.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4051DB39.4060905@astro.wisc.edu>
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
To: jansen <jansen@astro.wisc.edu>
Cc: autofs@linux.kernel.org

On Fri, 2004-03-12 at 07:46, jansen wrote:
> Hi,
> 
> I've been struggling to figure out why autofs does not appear
> to unmount many mount points.  I have more than 150 entries in
> a map file and most of these entries get mounted when I log into
> a Gnome session and never seem to ever get unmounted.  This
> happened under RedHat 8.0 (autofs-3.1.7-33) and still happens on
> SuSE 9.0 (autofs-3.1.7-717).  I'm guessing that Nautilus is doing
> this.  Is anyone else seeing this?  Any suggestions on how to prevent
> or debug this?  I can provide more details if anyone is interested.

I have the same problem, and I think that it is nautilus, too.  It
stores the files in .gnome/gnome-vfs/.trash_entry_cache.  You can clean
out that file, but they will come back if you mount them.  I haven't had
a chance yet to fix the problem instead of the symptoms...

Forrest
