From: Jeff Moyer <jmoyer@redhat.com>
Subject: questions on auto.master file format
Date: Tue, 2 Mar 2004 12:46:26 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16452.51314.769206.991484@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hello,

Reading through Sun's documentation, it seems that mount options specified
in auto.master should begin with a leading dash.  See the example here: 
   http://docs.sun.com/db/doc/816-0211/6m6nc66nc?q=automount&a=view

Is this something we want to be compatible with?  I suppose we could invert
the meaning of the - in auto.master, but that could break a whole lot of
people.  :(

Next, from the auto.master man page:

	Options are cumulative, which is a difference from the behavior of
	the SunOS automounter.

If there is a conflict between the options specified in auto.master and the
map file, which one takes precedence?  I looked through the code briefly,
and it seems to be unhandled.  Did I miss something?

Thanks!

-Jeff
