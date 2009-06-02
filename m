From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: unable to automount windows C$
Date: Tue, 02 Jun 2009 15:45:04 +1000
Message-ID: <4A24BC60.1020404@edcint.co.nz>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz> <4A0B808C.2030705@themaw.net>
	<4A0CC262.7020105@edcint.co.nz> <4A0D1630.3040407@themaw.net>
	<4A0FC156.10108@edcint.co.nz> <4A10BC5B.7010402@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5164937632854460695=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A10BC5B.7010402@themaw.net>
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
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============5164937632854460695==
Content-Type: multipart/alternative;
 boundary="------------090408080004080200090701"

This is a multi-part message in MIME format.
--------------090408080004080200090701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Ian Kent wrote:
> Matthew Jurgens wrote:
>   
>>>> Script updated and gsub commented out (like a message earlier in the
>>>> thread):
>>>> -fstype=cifs,username=USER,password=PASS \
>>>>         "/C" "://xp0/C" \
>>>>         "/ADMIN$" "://xp0/ADMIN$" \
>>>>         "/C$" "://xp0/C$"
>>>>
>>>> cd /smb/xp0/C$  gives
>>>> cd: no such file or directory: /smb/xp0/C$
>>>>
>>>> something is really busted now since I can't even cd /smb/xp0/C either.
>>>> I don't understand why the debug log contains what looks like parts of
>>>> the script as the output since running the script manually seems to have
>>>> perfectly clean output
>>>>     
>>>>         
>>> Because the script file is not executable now it is treating it as a
>>> file map not a program map.
>>>       
>> Not sure how you come to that conclusion since I ran it above to get the
>> output and it is
>> -rwxr-xr-x
>>     
>
> Because of:
> May 15 11:09:01 gw automount[20964]: attempting to mount entry /smb/xp0
> May 15 11:09:01 gw automount[20964]: lookup_mount: lookup(file): looking
> up xp0
>
> and since this is executed during the lookup:
>
> static int lookup_name_file_source_instance(struct autofs_point
> *ap, 				struct map_source *map, const char *name, int name_len)
>         struct map_source *instance;
>         char src_file[] = "file";
>         char src_prog[] = "program";
>         time_t age = time(NULL);
>         struct stat st;
>         char *type, *format;
>
>         if (stat(map->argv[0], &st) == -1) {
>                 warn(ap->logopt, "file map not found");
>                 return NSS_STATUS_NOTFOUND;
>         }
>
>         if (!S_ISREG(st.st_mode))
>                 return NSS_STATUS_NOTFOUND;
>
>         if (st.st_mode & __S_IEXEC)
>                 type = src_prog;
>         else
>                 type = src_file;
>
>         format = map->format;
> ....
>
>
>   
Sorry I must be missing something.
You say autofs is now treating the script as a file since it is not 
executable but it is executable.
I don't quite understand the "if (st.st_mode & __S_IEXEC)" part of the 
code above.

-- 
Smartmon System Monitoring <http://www.smartmon.com.au>
www.smartmon.com.au


--------------090408080004080200090701
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Ian Kent wrote:
<blockquote cite="mid:4A10BC5B.7010402@themaw.net" type="cite">
  <pre wrap="">Matthew Jurgens wrote:
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">Script updated and gsub commented out (like a message earlier in the
thread):
-fstype=cifs,username=USER,password=PASS \
        "/C" "://xp0/C" \
        "/ADMIN$" "://xp0/ADMIN$" \
        "/C$" "://xp0/C$"

cd /smb/xp0/C$  gives
cd: no such file or directory: /smb/xp0/C$

something is really busted now since I can't even cd /smb/xp0/C either.
I don't understand why the debug log contains what looks like parts of
the script as the output since running the script manually seems to have
perfectly clean output
    
        </pre>
      </blockquote>
      <pre wrap="">Because the script file is not executable now it is treating it as a
file map not a program map.
      </pre>
    </blockquote>
    <pre wrap="">Not sure how you come to that conclusion since I ran it above to get the
output and it is
-rwxr-xr-x
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Because of:
May 15 11:09:01 gw automount[20964]: attempting to mount entry /smb/xp0
May 15 11:09:01 gw automount[20964]: lookup_mount: lookup(file): looking
up xp0

and since this is executed during the lookup:

static int lookup_name_file_source_instance(struct autofs_point
*ap, 				struct map_source *map, const char *name, int name_len)
        struct map_source *instance;
        char src_file[] = "file";
        char src_prog[] = "program";
        time_t age = time(NULL);
        struct stat st;
        char *type, *format;

        if (stat(map-&gt;argv[0], &amp;st) == -1) {
                warn(ap-&gt;logopt, "file map not found");
                return NSS_STATUS_NOTFOUND;
        }

        if (!S_ISREG(st.st_mode))
                return NSS_STATUS_NOTFOUND;

        if (st.st_mode &amp; __S_IEXEC)
                type = src_prog;
        else
                type = src_file;

        format = map-&gt;format;
....


  </pre>
</blockquote>
Sorry I must be missing something.<br>
You say autofs is now treating the script as a file since it is not
executable but it is executable.<br>
I don't quite understand the "if (st.st_mode &amp; __S_IEXEC)" part of
the code above.<br>
<br>
<div class="moz-signature">-- <br>
<font size="2"><font face="Verdana">
<a href="http://www.smartmon.com.au">Smartmon System Monitoring</a><br>
<a class="moz-txt-link-abbreviated" href="http://www.smartmon.com.au">www.smartmon.com.au</a>
</font></font></div>
<br>
</body>
</html>

--------------090408080004080200090701--


--===============5164937632854460695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5164937632854460695==--

