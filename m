From: Dylan <autofs@dylan.me.uk>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 20:23:49 +0000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200401132023.49657.autofs@dylan.me.uk>
References: <200401131958.i0DJwlV0001078000@anw.zk3.dec.com>
	<40044F2A.9080305@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40044F2A.9080305@zytor.com>
Content-Disposition: inline
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
To: "H. Peter Anvin" <hpa@zytor.com>, Eric Werme USG <werme@alpha.zk3.dec.com>
Cc: autofs@linux.kernel.org

On Tuesday 13 January 2004 20:03 pm, H. Peter Anvin wrote:

> However, this doesn't address the issue of the client being *the same
> system*, in which case you can't just move the IP address away from
> it, since local == remote; you can no longer send packets to the
> server and get a response back.  You can do it if you can get the
> client and the server sides to bind to *different* IP addresses, in
> which case the current autofs behaviour will correctly see them as
> being separate and mount NFS.

Would binding an alias address to the interface be sufficient?

Dylan

-- 
Sweet moderation
Heart of this nation
Desert us not
We are between the wars
- Billy Bragg
