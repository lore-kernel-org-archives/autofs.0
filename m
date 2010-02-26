From: Robert Lazzurs <rob@lazzurs.net>
Subject: Laptop users with local home directory
Date: Fri, 26 Feb 2010 14:15:15 +0000
Message-ID: <1220a921002260615h420460f9w9a7b599ce49bfcd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:sender:received:date
	:x-google-sender-auth:message-id:subject:from:to:content-type;
	bh=m1jPX9r4tLJ86EwHZ3Eh5ljY/RZcJcFL6v0yhI6P0HI=;
	b=w1lSkbs9H55HXJkpVdKLUNDzs0j+MWj4W1nkoYAe0PJFQAJXiht3T296emE+JBC/DK
	pin74yvlGsfKFWxKFtfsK9xmCG2+yasDy28EtW8TRKHFMDNjdIc6ges4iJpUlfhiHb8g
	UzCLo/xUwzc3lvpKyo1PqEM94a5sUuLmp+Wpw=
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

Hello,

I have a number of laptop users that have both a local home directory
on their laptop and a NFS mounted home directory when they are in the
office.

What they want to be able to do is only use the local home directory
as their current home directory when the NFS server is not available.
So for example using the replicated syntax I tried something similar
to the following for a map on /homes/

username nfsserver:/home/username localhost:/home/username

The passwd entry would then point the user home directory to /homes/username.

The issue with this currently is that autofs will always prefer a
local mount over a network mount, even with weighting.  Is there any
way to provide this facility in a similar way to the replicated syntax
without using a script for the map?

Thanks in advance.
