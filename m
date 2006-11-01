From: Risto Bell <reb@cypress.com>
Subject: Re: autofs4: How to confg TCP 1st choice, not UPD?
Date: Wed, 01 Nov 2006 14:48:25 -0800
Message-ID: <45492439.9020409@cypress.com>
References: <mailman.122.1162331942.2205.autofs@linux.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <mailman.122.1162331942.2205.autofs@linux.kernel.org>
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
To: autofs@linux.kernel.org

Using RedHat Enterprise 3 update 6. Release notes consistent with
my experience that UDP is the default. Perhaps RedHat changed the
default autofs4's natural TCP back to UDP? In any event, question
remains: There isn't an simple config by which to control it (prefer
TCP with timeo=600,retrans=2 1st), it has to be compiled into it?

Also could use multi-mounts? List two alternative mounts, same but
one TCP and one UPD, so the 1st (TCP) will be attempted, and only if
it fails (server doesn't support TCP) will it fall to 2nd (UDP)?
This would still need programs/scripts but would save rcpinfo process,
and achieve slight speed-up.

% egrep -C4 ' autofs-4|NFS.*UDP' RELEASE-NOTES-en RELEASE-NOTES-U6-en
RELEASE-NOTES-en-     o The Red Hat Enterprise Linux 3 kernel now includes support for NFS
RELEASE-NOTES-en-       over TCP. To use NFS over TCP, you must include the "-o tcp" option to
RELEASE-NOTES-en-       mount when mounting the NFS-exported file system on the client system.
RELEASE-NOTES-en-
RELEASE-NOTES-en:       NOTE: The default transport protocol for NFS remains UDP. Use the
RELEASE-NOTES-en-       mount command with the "-o tcp" option to mount an NFS-exported file
RELEASE-NOTES-en-       system using TCP; otherwise, UDP will be used by default.
RELEASE-NOTES-en-
RELEASE-NOTES-en-     o In this kernel, the following command has been added to scan for new
--
RELEASE-NOTES-U6-en-     o anaconda-9.1.5.8-1.RHEL => anaconda-9.1.6.8-1.RHEL
RELEASE-NOTES-U6-en-
RELEASE-NOTES-U6-en-     o anaconda-runtime-9.1.5.8-1.RHEL => anaconda-runtime-9.1.6.8-1.RHEL
RELEASE-NOTES-U6-en-
RELEASE-NOTES-U6-en:     o autofs-4.1.3-130 => autofs-4.1.3-150
RELEASE-NOTES-U6-en-
RELEASE-NOTES-U6-en-     o binutils-2.14.90.0.4-37 => binutils-2.14.90.0.4-39
RELEASE-NOTES-U6-en-
RELEASE-NOTES-U6-en-     o bonobo-activation-2.2.2-1 => bonobo-activation-2.2.2-1.2E
