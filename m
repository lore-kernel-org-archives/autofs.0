From: Stef Bon <stef@bononline.nl>
Subject: Re: Indirect mounts: name of network as key.
Date: Tue, 22 Apr 2008 12:07:31 +0200
Message-ID: <480DB8E3.8060705@bononline.nl>
References: <480DA66B.9020806@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <480DA66B.9020806@bononline.nl>
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

Stef Bon wrote:
> Hello,
>
>
> When the key is "SSH hosts", it's output is:
>
> -fstype=sshfs \
>     /192.168.0.1 -rw,nodev,nonempty,noatime ://sbon@192.168.0.1:/ \
>     /192.168.0.2 -rw,nodev,nonempty,noatime ://sbon@192.168.0.2:/ \
>
>   
Some program is replacing the literal \@ by an "at" on the website, not 
the mail.

I hope this comes through all right:

-fstype=sshfs \
    /192.168.0.1 -rw,nodev,nonempty,noatime ://sbon\@192.168.0.1:/ \
    /192.168.0.2 -rw,nodev,nonempty,noatime ://sbon\@192.168.0.2:/ \


Stef Bon
