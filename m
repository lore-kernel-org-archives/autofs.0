From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] starttls for autofs-ldap-auto-master.c (actually
	attaching it this time.)
Date: Mon, 27 Mar 2006 12:34:36 -0500
Message-ID: <17448.8748.465963.850118@segfault.boston.redhat.com>
References: <20060323175511.GE12245@nmt.edu>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060323175511.GE12245@nmt.edu>
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
To: "Anthony M. Martinez" <twopir@nmt.edu>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] [PATCH] starttls for autofs-ldap-auto-master.c (actually attaching it this time.); "Anthony M. Martinez" <twopir@nmt.edu> adds:

twopir> Since our LDAP server is configured to require confidentiality, I made
twopir> the program default to using it.

That's great for your environment, but breaks most everyone else.  How
about making this configurable and not changing the default?  For Debian,
I'm guessing the configuration would be stored in /etc/default/autofs.  For
Red Hat systems, it would use /etc/sysconfig/autofs.

-Jeff
