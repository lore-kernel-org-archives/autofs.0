From: David Meleedy <david.meleedy@analog.com>
Subject: Re: Re: Intermittant problems mounting with automounter
Date: Tue, 14 Dec 2004 18:36:16 -0500
Message-ID: <200412142336.iBENaGkj000596@jetcar.spd.analog.com>
References: <41BEF472.EAAE7682@ssa.crane.navy.mil>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Tue, 14 Dec 2004 09:10:58 EST."
	<41BEF472.EAAE7682@ssa.crane.navy.mil> 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Cc: autofs@linux.kernel.org


> Check on your server, the above looks like messages I have seen on some
> clients lately, and see if you have messages of the form
> Nov 19 11:27:?? server rpc.mountd: getfh failed: Operation not permitted

I haven't seen this error in any of the cases.  As far as I know
"hard" mounts are the default behavior.  I have not specified "soft"
mounts as an option.

from the nfs man page:
 
      hard           If an NFS file operation has a major timeout then report
                      "server not responding"  on  the  console  and  continue
                      retrying indefinitely.  This is the default.

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
