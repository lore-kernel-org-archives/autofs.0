From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: smbfs credentias
Date: Wed, 5 Jan 2005 13:34:18 -0500
Message-ID: <16860.13098.782113.189445@segfault.boston.redhat.com>
References: <20050105131618.1ccfca62@localhost>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050105131618.1ccfca62@localhost>
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
To: abo <abo@brujulatelecom.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] smbfs credentias; abo <abo@brujulatelecom.com> adds:

abo> hi!  im trying to mount smbfs resources from an ldap

abo> if i put in nisMapEntry this

abo> -fstype=smbfs,credentials=/home/abo/smb.creds

abo> everything is working right. then i want to do it per user but
abo> variable substitution doesn't work, i tried:

abo> -fstype=smbfs,credentials=/home/$USER/smb.creds

abo> -fstype=smbfs,credentials=/home/${USER}/smb.creds

abo> -fstype=smbfs,credentials=~/smb.creds

abo> but no succes.

abo> how can i get per user credentiasl? im on the wrong direction?

The automounter runs as user root.  It has no way of knowing which user
requested a given mount.

-Jeff
