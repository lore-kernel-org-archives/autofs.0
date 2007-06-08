From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: unmount immediately followed by remount
Date: Fri, 08 Jun 2007 16:10:58 -0400
Message-ID: <m34pli4371.fsf@redhat.com>
References: <200706081429.02284.jweber@amsuper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200706081429.02284.jweber@amsuper.com> (Jeff Weber's message of
	"Fri, 8 Jun 2007 14:29:02 -0500")
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
To: Jeff Weber <jweber@amsuper.com>
Cc: autofs@linux.kernel.org

==> On Fri, 8 Jun 2007 14:29:02 -0500, Jeff Weber <jweber@amsuper.com> said:

Jeff> I have 2 WinXP servers, I am automounting using smbs.  For one
Jeff> server, the automounter unmounts the smbfs after inactivity as
Jeff> expected.  For the other server, supermad2, the automounter
Jeff> expires and unmounts the 4 shares after approx the 60sec
Jeff> timeout, as expected.  However, the shares are then immediately
Jeff> remounted.  Thus, the shares from the server are effectively
Jeff> continuously mounted.  Here's some sample automount debug
Jeff> output:

This used to happen with older versions of hal:

     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=192923

-Jeff
