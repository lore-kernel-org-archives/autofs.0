From: ramana <ramana@intraperson.com>
Subject: Re: Autodir
Date: Fri, 18 Jun 2004 07:16:31 +0530
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40D24977.7030706@intraperson.com>
References: <LYRIS-1845620-699584-2004.04.19-05.42.49--ramana#intraperson.com@listserver.itd.umich.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <LYRIS-1845620-699584-2004.04.19-05.42.49--ramana#intraperson.com@listserver.itd.umich.edu>
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

ramana wrote:

> I work on Linux.
>
> Its not pure ldap question but it does not fit exactly to any mailing 
> list I know. So I decided to ask here.
>
> Posix/shadow ldap accounts have home directory associated with them. I 
> can get those accounts to any server which require them --for example 
> using nss_ldap.
>
> But the question is how to create home directories on the server 
> automatically as IMAP and other servers depend heavily on physical 
> presence of home directories.
>
> One solution is pam_mkhomedir, But it only works when the server uid=0.
>
> Any better solutions such that it should be transparent to the server 
> and works with any server.
>
> Because I am planning to code a very simple solution -- to be used 
> with autofs to solve this problem. If there is better solution I 
> consider that.
>
> Regards
> ramana
>
This what I posted to ldap mailing list once.

Regards
ramana

-- 
http://www.intraperson.com
