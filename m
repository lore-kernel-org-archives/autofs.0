From: Milan Knizek <knizek@volny.cz>
Subject: Re: How to automount hidden Windows share - solved
Date: Thu, 27 Jan 2005 16:57:47 +0000
Message-ID: <41F91D8B.6040501@volny.cz>
References: <41F8A365.8080808@volny.cz>
	<Pine.LNX.4.61.0501272016470.8888@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501272016470.8888@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

raven@themaw.net wrote:
> On Thu, 27 Jan 2005, Milan Knizek wrote:
> 
>> n -fstype=smbfs,users,uid=knizek_m,gid=users,credentials=/etc/samba
> 
>        What's this^^^^^
...
> This looks like a parsing problem. But I would have expected escaping 
> the $ to have worked.

I got rid of the non-sense option users and escaped the $, rebooted and
now it works just fine.

n
-fstype=smbfs,codepage=cp852,iocharset=iso8859-2,uid=knizek_m,gid=users,credentials=/etc/samba/crede
ntials_argon ://ffile01/Home\$

I think that the 'users' option should not have a big influence, since
automounting worked for other non-hidden Windows shares with this 
option, too. Now I am busy with other issues, but later I will try to 
reproduce the error again (probably relates to restarting the init 
service) and let you know if I succeed.

Thank you for input.

Milan
knizek@volny.cz
