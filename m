From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs4: How to confg TCP 1st choice, not UPD?
Date: Wed, 01 Nov 2006 18:14:00 -0500
Message-ID: <x49k62e69qf.fsf@segfault.boston.devel.redhat.com>
References: <mailman.122.1162331942.2205.autofs@linux.kernel.org>
	<45492439.9020409@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45492439.9020409@cypress.com> (Risto Bell's message of "Wed,
	01 Nov 2006 14:48:25 -0800")
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
To: Risto Bell <reb@cypress.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] autofs4: How to confg TCP 1st choice, not UPD?; Risto Bell <reb@cypress.com> adds:

reb> Using RedHat Enterprise 3 update 6. Release notes consistent with
reb> my experience that UDP is the default. Perhaps RedHat changed the
reb> default autofs4's natural TCP back to UDP? In any event, question
reb> remains: There isn't an simple config by which to control it (prefer
reb> TCP with timeo=600,retrans=2 1st), it has to be compiled into it?

The default is not embedded in autofs, it's part of the mount command
and/or the kernel mount implementation.  My system is RHEL 5 beta, so much
newer than yours.

reb> Also could use multi-mounts? List two alternative mounts, same but
reb> one TCP and one UPD, so the 1st (TCP) will be attempted, and only if
reb> it fails (server doesn't support TCP) will it fall to 2nd (UDP)?
reb> This would still need programs/scripts but would save rcpinfo process,
reb> and achieve slight speed-up.

Please don't do this.  It is not the correct way to go about doing things,
and it will not work.  The reason is that when trying a replicated server,
if we fail to mount we mark the server as down.  So, your subsequent
request will also fail.

-Jeff
