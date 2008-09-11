From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: Not correctly mount SMB shares ending in $
Date: Thu, 11 Sep 2008 18:34:06 +1000
Message-ID: <48C8D7FE.9000501@edcint.co.nz>
References: <48C5F518.9010800@edcint.co.nz>
	<1221018586.3030.63.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1221018586.3030.63.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

That's interesting. Identical output from a working and the failing host.

 From a working host:
-fstype=cifs,username=USER,password=PASSWORD \
         /C "://xp0/C" \
         /ADMIN\$ "://xp0/ADMIN\$" \
         /C\$ "://xp0/C\$"


 From the failing 5.0.3 host:
-fstype=cifs,username=USER,password=PASSWORD \
         /C "://xp0/C" \
         /ADMIN\$ "://xp0/ADMIN\$" \
         /C\$ "://xp0/C\$"


Ian Kent wrote:
> Can you post the output of the program map please.
> That's probably "sh /etc/auto.smb <server name>".
>
> Ian
>
>
>
>   
