From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Do Include Maps Work With LDAP
Date: Fri, 13 Jul 2007 12:02:50 -0400
Message-ID: <x49fy3s70lx.fsf@segfault.boston.devel.redhat.com>
References: <1184339287.27865.20.camel@houuc8>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1184339287.27865.20.camel@houuc8> (Steve Rigler's message of
	"Fri\, 13 Jul 2007 10\:08\:07 -0500")
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
To: Steve Rigler <srigler@marathonoil.com>
Cc: autofs@linux.kernel.org

==> On Fri, 13 Jul 2007 10:08:07 -0500, Steve Rigler <srigler@marathonoil.com> said:

Steve> We are running autofs-4.1.3-199.3 on RHEL 4.5.  The changelog states
Steve> that include maps can be used to "include a nis map of the same name".

Steve> I am attempting this with LDAP and was wondering if it was supported or
Steve> even possible.  What I've noticed is that the include directive will
Steve> only handle the map name (using the DN gives a message that "nsswitch:
Steve> couldn't find map").  When using the map name *all* it looks like
Steve> automount includes all of the keys from all of our maps rather than just
Steve> the ones in the map we're trying to include.

Steve> Does this only work with NIS or should it be possible with LDAP?

Please provide the information requested on my people page:
  http://people.redhat.com/jmoyer/

And, since this is a Red Hat package, it might be better to simply
open a bugzilla:
  http://bugzilla.redhat.com/

Thanks,

Jeff
