From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Here's a new really odd auto.net bug
Date: Fri, 5 Aug 2005 14:07:30 -0700 (PDT)
Message-ID: <200508052107.j75L7Tid019987@crowley.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: INLINE
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
To: autofs@linux.kernel.org

On  4 Aug, Michael Marion wrote:

> Trying some more things...

Turns out it was my fault again.. I seem to have built the daemon for
sles9-sp1 and sp2 and missed one of the patches.  I rebuilt it again to make
damn sure I hadn't, and the new build works properly. 

Don't know how I missed a patch when I built it for the suse9.2 host at the
same time and didn't miss it.

I'm thinking those 3 patches need to be rolled into the main codebase.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
"This software comes with ABSOLUTELY NO WARRANTY. Even if it erases your hard
drive, too bad. Although we did fix that bug from the last release." 
==> README from a long-ago release of DJGPP 
