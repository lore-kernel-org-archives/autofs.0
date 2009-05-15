From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Fri, 15 May 2009 15:13:52 +0800
Message-ID: <4A0D1630.3040407@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz> <4A0B808C.2030705@themaw.net>
	<4A0CC262.7020105@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0CC262.7020105@edcint.co.nz>
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
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: autofs@linux.kernel.org

Matthew Jurgens wrote:
> 
>> Of course, it then doesn't escape $ in the offsets.
>> But, it looks like your script isn't up to date.
>> I'm fairly sure the current script should output:
>>  -fstype=cifs,username=USER,password=PASS \
>>          "/C" "://xp0/C" \
>>          "/ADMIN$" "://xp0/ADMIN$" \
>>          "/C$" "://xp0/C$"
>>
>> which is why I thought we shouldn't need the "\" escapes.
>> Can you check your auto.smb against the one attached please, in
>> particular the last line at the bottom of the "/Disk/" block should be:
>>
>> print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""
>>
>> Ian
>>   
> Script updated and gsub commented out (like a message earlier in the
> thread):
> -fstype=cifs,username=USER,password=PASS \
>         "/C" "://xp0/C" \
>         "/ADMIN$" "://xp0/ADMIN$" \
>         "/C$" "://xp0/C$"
> 
> cd /smb/xp0/C$  gives
> cd: no such file or directory: /smb/xp0/C$
> 
> something is really busted now since I can't even cd /smb/xp0/C either.
> I don't understand why the debug log contains what looks like parts of
> the script as the output since running the script manually seems to have
> perfectly clean output

Because the script file is not executable now it is treating it as a
file map not a program map.

> 
> debug output is:
> May 15 11:09:01 gw automount[20964]: st_expire: state 1 path /smb
> May 15 11:09:01 gw automount[20964]: expire_proc: exp_proc = 3082091408
> path /smb
> May 15 11:09:01 gw automount[20964]: expire_cleanup: got thid 3082091408
> path /smb stat 0
> May 15 11:09:01 gw automount[20964]: expire_cleanup: sigchld: exp
> 3082091408 finished, switching from 2 to 1
> May 15 11:09:01 gw automount[20964]: st_ready: st_ready(): state = 2
> path /smb
> May 15 11:09:01 gw automount[20964]: handle_packet: type = 3
> May 15 11:09:01 gw automount[20964]: handle_packet_missing_indirect:
> token 101, name xp0, request pid 17443
> May 15 11:09:01 gw automount[20964]: attempting to mount entry /smb/xp0
> May 15 11:09:01 gw automount[20964]: lookup_mount: lookup(file): looking
> up xp0
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "[ -x
> $P/smbclient ]..." for key "if"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "-A
> $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v opts="$opts"
> -F'|' -- '..." for key "$SMBCLIENT"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "[ -x
> $P/smbclient ]..." for key "if"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "-A
> $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v opts="$opts"
> -F'|' -- '..." for key "$SMBCLIENT"
> May 15 11:09:01 gw automount[20964]: lookup_nss_mount: key "xp0" not
> found in map.
> May 15 11:09:01 gw automount[20964]: send_fail: token = 101
> May 15 11:09:01 gw automount[20964]: failed to mount /smb/xp0
> May 15 11:09:01 gw automount[20964]: handle_packet: type = 3
> May 15 11:09:01 gw automount[20964]: handle_packet_missing_indirect:
> token 102, name xp0, request pid 17443
> May 15 11:09:01 gw automount[20964]: attempting to mount entry /smb/xp0
> May 15 11:09:01 gw automount[20964]: lookup_mount: lookup(file): looking
> up xp0
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "[ -x
> $P/smbclient ]..." for key "if"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "-A
> $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v opts="$opts"
> -F'|' -- '..." for key "$SMBCLIENT"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "[ -x
> $P/smbclient ]..." for key "if"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "-A
> $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v opts="$opts"
> -F'|' -- '..." for key "$SMBCLIENT"
> May 15 11:09:01 gw automount[20964]: lookup_nss_mount: key "xp0" not
> found in map.
> May 15 11:09:01 gw automount[20964]: send_fail: token = 102
> May 15 11:09:01 gw automount[20964]: failed to mount /smb/xp0
> May 15 11:09:01 gw automount[20964]: handle_packet: type = 3
> May 15 11:09:01 gw automount[20964]: handle_packet_missing_indirect:
> token 103, name xp0, request pid 17443
> May 15 11:09:01 gw automount[20964]: attempting to mount entry /smb/xp0
> May 15 11:09:01 gw automount[20964]: lookup_mount: lookup(file): looking
> up xp0
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "[ -x
> $P/smbclient ]..." for key "if"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "-A
> $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v opts="$opts"
> -F'|' -- '..." for key "$SMBCLIENT"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "[ -x
> $P/smbclient ]..." for key "if"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "-A
> $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v opts="$opts"
> -F'|' -- '..." for key "$SMBCLIENT"
> May 15 11:09:01 gw automount[20964]: lookup_nss_mount: key "xp0" not
> found in map.
> May 15 11:09:01 gw automount[20964]: send_fail: token = 103
> May 15 11:09:01 gw automount[20964]: failed to mount /smb/xp0
> May 15 11:09:01 gw automount[20964]: handle_packet: type = 3
> May 15 11:09:01 gw automount[20964]: handle_packet_missing_indirect:
> token 104, name xp0, request pid 17443
> May 15 11:09:01 gw automount[20964]: attempting to mount entry /smb/xp0
> May 15 11:09:01 gw automount[20964]: lookup_mount: lookup(file): looking
> up xp0
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "[ -x
> $P/smbclient ]..." for key "if"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "-A
> $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v opts="$opts"
> -F'|' -- '..." for key "$SMBCLIENT"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "[ -x
> $P/smbclient ]..." for key "if"
> May 15 11:09:01 gw automount[20964]: lookup(file): bad map entry "-A
> $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v opts="$opts"
> -F'|' -- '..." for key "$SMBCLIENT"
> May 15 11:09:01 gw automount[20964]: lookup_nss_mount: key "xp0" not
> found in map.
> May 15 11:09:01 gw automount[20964]: send_fail: token = 104
> May 15 11:09:01 gw automount[20964]: failed to mount /smb/xp0
> 
> 
> 
> 
