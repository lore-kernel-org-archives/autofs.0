From: Stef Bon <stef@bononline.nl>
Subject: Re: bug doing simple stat call to mountpoint
Date: Sun, 05 Jun 2011 23:37:01 +0200
Message-ID: <4DEBF6FD.8050407@bononline.nl>
References: <4DEBB25B.3020509@bononline.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4DEBB25B.3020509@bononline.nl>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

  On 06/05/2011 06:44 PM, Stef Bon wrote:
>  Hi,
>
> I'm using autofs 5.0.5, kernel 2.6.38.6.
>
> In the construction I'm working on I got the following error:
>
> stat /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1
> stat: cannot stat 
> `/mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1': No such 
> file or directory
> sbon [ 
> /tmp/mount.md5key/users/sbon/cache/0a8805e89f4cc6653185a4ec4335cca1 ]$ 
> ls /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1
> <gives contents as expected> 

I've tried linux 2.6.39.1, and same behaviour. I'll try an older kernel 
(2.6.37....)

Stef
