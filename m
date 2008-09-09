From: Mike Marion <mmarion@qualcomm.com>
Subject: 5.0.3 oddity with LDAP map
Date: Tue, 9 Sep 2008 15:04:16 -0700
Message-ID: <20080909220416.GB22997@u20m2mm.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@kernel.org

Taking my first real stab at testing 5.0.3 (patched up to all patches in
the patch_order file from last night).  Have been sticking to supported
autofs5 from Novell on our hosts thus far, but still having some issues
here and there (long story, mostly because we have HUGE maps I think)
but ran into a problem starting 5.0.3.  It seems to be truncating info
the ldap server gives it.  The patches all successfully applied and the
compile went smoothly.

The debug info shows failure to mount like:
do_bind: lookup(ldap): ldap anonymous bind returned 0
get_query_dn: lookup(ldap): query succeeded, no matches for (&(objectclass=automountMap)(automountMapName=o.projects))
do_bind: lookup(ldap): failed to get query dn
lookup(ldap): couldn't connect to server default
do_read_map: lookup module ldap failed
mount_autofs_direct: failed to read direct map
handle_mounts: mount of /- failed!
master_do_mount: failed to startup mount

The automountMapName=o.projects above should be =auto.projects.. it
seems to be truncating the "aut" from "auto".  This seems to happen for
each result, strace shows it getting the right answer, then coming back
for the next maps with the truncation:
[strace info here only including the stuff I want to save space]
7109  read(5, "\246\4cautomountKey=/-,automountMapName=auto_master,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com0?0\'\4\24automountInformation1\17\4\rauto.projects0\24\4\fautomountKey1\4\4\2/-", 167) = 167
7130  write(2, "lookup_nss_read_map: reading map ldap o.projects", 48) = 48
7130  write(2, "parse_server_string: lookup(ldap): Attempting to parse LDAP information from string \"o.projects\".", 97) = 97
7130  write(2, "parse_server_string: lookup(ldap): mapname o.projects", 53) = 53
7130  write(10, "0\201\217\2\1\2c\201\211\4%ou=sandiego,ou=qct,dc=qualcomm,dc=com\n\1\2\n\1\3\2\1\0\2\1\0\1\1\0\240=\243\33\4\vobjectclass\4\fautomountMap\243\36\4\20automountMapName\4\no.projects0\22\4\20automountMapName", 146) = 146
7130  write(2, "get_query_dn: lookup(ldap): query succeeded, no matches for (&(objectclass=automountMap)(automountMapName=o.projects))", 118) = 118

same for auto.home:
mmarion@lnxlabbld3:/> grep o.home /tmp/out.autofs
7109  read(5, "\250\4fautomountKey=/usr2,automountMapName=auto_master,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com0>0#\4\24automountInformation1\v\4\tauto.home0\27\4\fautomountKey1\7\4\5/usr2", 169) = 169
7134  write(2, "lookup_nss_read_map: reading map ldap o.home", 44) = 44
7134  write(2, "parse_server_string: lookup(ldap): Attempting to parse LDAP information from string \"o.home\".", 93) = 93
7134  write(2, "parse_server_string: lookup(ldap): mapname o.home", 49) = 49
7134  write(21, "0\201\213\2\1\2c\201\205\4%ou=sandiego,ou=qct,dc=qualcomm,dc=com\n\1\2\n\1\3\2\1\0\2\1\0\1\1\0\2409\243\33\4\vobjectclass\4\fautomountMap\243\32\4\20automountMapName\4\6o.home0\22\4\20automountMapName", 142) = 142
7134  write(2, "get_query_dn: lookup(ldap): query succeeded, no matches for (&(objectclass=automountMap)(automountMapName=o.home))", 114) = 114

This is on a stock sles10-sp2 host, with openafs added (which wouldn't
touch this anyway).  Not sure why the ldap info is being truncated like
the above.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
"A home pool inevitably results in storing large quantities of the chemical 
dihydrogen oxide where household members may be exposed to it. Acute 
overexposure to dihydrogen oxide probably results in more fatalities each year 
than overexposure to any other single chemical! Of course, dihydrogen oxide is 
more commonly known as water, and acute overexposure to water is usually called 
drowning." -- Taken from pool owner tips at www.poolsolutions.com
