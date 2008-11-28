From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Automounter hangs...
Date: Fri, 28 Nov 2008 16:31:06 +0100
Message-ID: <49300EBA.3020505@s3group.cz>
References: <48A03A9B.2070402@s3group.cz>
	<x49pro3yemn.fsf@segfault.boston.devel.redhat.com>
	<48B251BE.4050105@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48B251BE.4050105@s3group.cz>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Hi All,

I hoped this went away forever, but I was wrong (unfortunately). Here we
go again:
RHEL-4, full updates, autofs 4, automounter hangs:
ps -ef | grep auto:
root      3805     1  0 Nov21 ?        00:00:00 /usr/sbin/automount
--timeout=3600 --debug --use-old-ldap-lookup /softappli yp
auto.softappli -rw
root      3880     1  0 Nov21 ?        00:00:00 /usr/sbin/automount
--timeout=3600 --debug --use-old-ldap-lookup /cadappl yp auto.cadappl -rw
root      3947     1  0 Nov21 ?        00:00:00 /usr/sbin/automount
--timeout=3600 --debug --use-old-ldap-lookup /appli yp auto.appli -rw
root      4032     1  0 Nov21 ?        00:00:00 /usr/sbin/automount
--timeout=3600 --debug --use-old-ldap-lookup /proj yp auto.proj -rw
root      4118     1  0 Nov21 ?        00:00:00 /usr/sbin/automount
--timeout=3600 --debug --use-old-ldap-lookup /home yp auto.home -rw
root     18848  4032  0 Nov27 ?        00:00:00 /usr/sbin/automount
--timeout=3600 --debug --use-old-ldap-lookup /proj yp auto.proj -rw
root     18851  4032  0 Nov27 ?        00:00:00 [automount] <defunct>
root     28454 21820  0 15:25 pts/134  00:00:00 grep auto

Debug logs:
Nov 27 13:07:28 login02 automount[4032]: sig 14 switching from 1 to 2
Nov 27 13:07:28 login02 automount[4032]: get_pkt: state 1, next 2
Nov 27 13:07:28 login02 automount[4032]: st_expire(): state = 1
Nov 27 13:07:28 login02 automount[4032]: expire_proc: exp_proc=18848
Nov 27 13:07:28 login02 automount[4032]: handle_packet: type = 2
Nov 27 13:07:28 login02 automount[4032]: handle_packet_expire_multi:
token 7150, name towerip
Nov 27 13:07:28 login02 automount[18849]: expiring path /proj/towerip
Nov 27 13:07:28 login02 automount[18849]: umount_multi:
path=/proj/towerip incl=1
Nov 27 13:07:28 login02 automount[18849]: umount_multi: unmounting
dir=/proj/towerip
Nov 27 13:07:28 login02 automount[18849]: expired /proj/towerip
Nov 27 13:07:28 login02 automount[4032]: handle_child: got pid 18849,
sig 0 (0), stat 0
Nov 27 13:07:28 login02 automount[4032]: sig_child: found pending iop
pid 18849: signalled 0 (sig 0), exit status 0
Nov 27 13:07:28 login02 automount[4032]: send_ready: token=7150
Nov 27 13:07:28 login02 automount[4032]: handle_packet: type = 2
Nov 27 13:07:28 login02 automount[4032]: handle_packet_expire_multi:
token 7151, name pdld4
Nov 27 13:07:28 login02 automount[18851]: expiring path /proj/pdld4
Nov 27 13:07:28 login02 automount[18851]: umount_multi: path=/proj/pdld4
incl=1
Nov 27 13:07:28 login02 automount[18851]: umount_multi: unmounting
dir=/proj/pdld4
Nov 27 13:07:28 login02 automount[18851]: expired /proj/pdld4
Nov 27 13:07:28 login02 automount[4032]: handle_packet: type = 0
Nov 27 13:07:28 login02 automount[4032]: handle_packet_missing: token
7152, name towerip

The automounter daemon handling the /proj map stalled.
Please help.
Thanks,

Ondrej

Ondrej Valousek wrote:
> Hi Jeff,
>
> Yes I am trying to reproduce this with the debug enabled - it will take
> some time.
> Please stay tuned.
>
> Ondrej
>   
>> It rings a bell, but I can't put my finger on it.  Can you reproduce
>> this?  If so, could you send along a debug log?  Instructions for
>> collecting debug information can be found at:
>>   http://people.redhat.com/~jmoyer/
>>
>> Cheers,
>>
>> Jeff
>>   
>>     
>
>
>   
