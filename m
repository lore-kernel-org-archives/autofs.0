From: ramana <ramana@intraperson.com>
Subject: Re: exporting autofs managed directory using NFS
Date: Fri, 25 Jun 2004 20:02:03 +0530
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40DC3763.7060501@intraperson.com>
References: <40DADD60.5090201@intraperson.com>
	<16603.10543.236802.870131@segfault.boston.redhat.com>
	<40DB7F5F.5070500@intraperson.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40DB7F5F.5070500@intraperson.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org
Cc: hpa@zytor.com


>>
>
>
> No. Autodir do mount local directories only on autofs mounted fs.
>
> In simple terms, exporting this special case autofs mounted dir using 
> nfs.
>
> Please check http://www.intraperson.com/autodir.html
>
I suspect and almost sure that this problem is because of  'The "magic" 
process group'.

Any comments?

Regards
ramana

-- 
http://www.intraperson.com
