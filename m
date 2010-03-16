From: Techie <techchavez@gmail.com>
Subject: sloppy mount and lockd
Date: Tue, 16 Mar 2010 12:03:53 -0700
Message-ID: <dc3ecf561003161203u3b47f3c3jbebf311146310402@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:date:message-id:subject
	:from:to:content-type;
	bh=QcPNsiug4tErDwsxX8ooYUuL8JvyY+JEeGb9Df+BFLE=;
	b=Z8tn+fE4zWfSgpjd5qxJ6JWG4MImnI4BWr+ic86PDzHVukAcVGw6H3mRNm3pyijPnn
	S7vu1w1FD1Foh/1TspSZe4TJ8KCm0Y4CyS6fdiOjocdkKsswalWu2NHvTzBS04zAjSjI
	J2NNFK7NOz7u5DEf+pj/sbqrJ6evBZZIPeSnc=
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi Ian,

I get these in the kernel log
svc: failed to register lockdv1 RPC service error no. 97
I have no idea why but using fstab does not produce these errors so
just curious if they are troublesome or if you have seen this before.
I have had autofs die a couple of times and wondering if its related
to this in any way.

Also if you have an idea why the mounts show as "sloppy" for my Autofs
mounts but not fstab mounts?. I read that it is to support
unrecognized options from the NFS servers such as -nobrowse. Is there
a way to prevent this or can it be safely ignored?

Thank you
J
