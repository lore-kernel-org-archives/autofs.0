From: Marcos Diez <marcos@unitron.com.br>
Subject: nonroot umount  for autofs
Date: Mon, 10 Jul 2006 22:22:02 +0000
Message-ID: <44B2D30A.20301@unitron.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010402060101000902040207"
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------010402060101000902040207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


In a Unix desktop system automount is very practical for CDROMs, digital
cameras, USB flash drives and any other type of removable media.
But it is annoying to the unprivileged user to wait the timeout to
remove the media.

Since it is insecure to allow the user to do a "killall -s SIGUSR1
automount", I wrote a program that does exactly (and only) that. Of
course it must be suid root, but it makes life much easier. I double
verified that there are no buffer overflows and I believe it's safe. The
program is not interactive, so a malicious user can't do much with it
anyway.

It gets the PIDs from instances of automount by parsing /proc/mounts
It would be nice if it could be added to the autofs distribution.


To compile:

gcc -O3 -ansi -Wall -pedantic umounter.c -o umounter

To install:
cp umounter /usr/local/bin && chmod 4711 /usr/local/bin/umounter

To use:

umounter
or
umounter --verbose
(show the signaled PIDs )


Thanks

-- 
Marcos Diez
+49 178 507 9577
Skype: aboboraabobora

--------------010402060101000902040207
Content-Type: text/x-csrc;
 name="umounter.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="umounter.c"


/*
 * Copyright (C) 2006 Marcos Diez marcos*AT*unitron.com.br
 *

this program sends SIGUSR1 to all running instances of automount,
who is should unmount all automounted directories.

is perfect for desktop systems, where users stick USB flash drives,
digital cameras and CDs.
Unfortumatelly, the program must be suid root to be used by a normal used.

at least, it is not interactive!
to use:
gcc -ansi -Wall -pedantic umounter.c -o /bin/umounter && chmod 4711 /bin/umounter

remember that if suid bits do not work on nonsuid partitions


 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public Licens
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-
 *
 */


#include <stdio.h>
#include <stdlib.h>

#include <errno.h>
#include <string.h>
#include <signal.h>

#include <unistd.h>
#include <sys/types.h>

#include <stdbool.h>

bool verbose=false;
int kill(pid_t pid, int sig);

#define AUTOMOUNT_IDENT "\nautomount(pid"
#define AUTOMOUNT_FSTYPE "autofs"
#define NO_AUTOMOUNT_PID_FOUND -10

static long searchStringInFile( FILE *theFile , char *theString ){
  /* returns the position of the string in the file
     colateral effect: changes the position of the file to right after the string was found
  */
  char *toBeSearched = theString;
  int c;


  while( (c = fgetc( theFile) ) != EOF ){
    if( c == *toBeSearched ){
      if( *++toBeSearched == 0){
	/* we found it ! */
	return ftell( theFile ) - strlen( theString );
      }
    }else{
      /* false match... too bad. we have to start if over */
      toBeSearched = theString;
    }
  }
  return -1;
}


static pid_t getNextAutoMountPid( FILE *mountsFile ){
  /* return the next automount pid found at /proc/mounts or NO_AUTOMOUNT_PID_FOUND */

  char buffer[21];
  long fPos;
  int pid;
  
  while( ( fPos = searchStringInFile( mountsFile , AUTOMOUNT_IDENT ) ) != -1 ){
    
    /* it MUST start with \n, or else it is not the beginning of the line,
       else, an evil user could mount something at /home/evilUser/automount(pidXXXX)/ where pidXXXX is the process a user wants to kill */

    /* now we EXTRA verify if the the filesystem type is AUTOMOUNT_FSTYPE */
    fseek( mountsFile , fPos +1  , SEEK_SET  );
    fscanf( mountsFile , "%*s %*s %20s" , buffer );
    if( strcmp( buffer , AUTOMOUNT_FSTYPE ) ){
      /* invalid filesystem type */
      continue;
    }
    

    /* now we believe we have something like [automount(pid4129) /mnt/auto autofs rw 0 0]  */
    fseek( mountsFile , fPos + sizeof( AUTOMOUNT_IDENT ) -1 , SEEK_SET  );
    fgets( buffer , sizeof(buffer) , mountsFile );
    pid = atoi( buffer );

    if( pid <1 ) return NO_AUTOMOUNT_PID_FOUND;
    return pid;

  }
  return NO_AUTOMOUNT_PID_FOUND;
    
}

static int sendSignalToAllAutoMounts( int sig ){
  /* send sig to all running instances of automount. returns the number of signals sent */
  FILE *mountsFile;
  pid_t pid;
  int numSignalsSend=0;

  if( !(mountsFile = fopen( "/proc/mounts" , "r")) ){
    fprintf( stderr , "ERROR: Umounter was not able to read /proc/mounts\n");
    exit(3);
  }


  
  while( (pid = getNextAutoMountPid( mountsFile ) ) != NO_AUTOMOUNT_PID_FOUND ){
    numSignalsSend++;
    if( kill( pid , SIGUSR1 ) == -1 ){ 
      switch( errno ) {
      case EINVAL:
	fprintf( stderr , "ERROR: SIGUSR1 is not a valid signal at this system.\n");
	break;
	/* should not happen, since I am root */
      case EPERM:
	fprintf( stderr , "ERROR: Umounter does not not have permission to send the signal to PID %d\n" , pid);
	exit( EPERM );
	break;
      case ESRCH:
	/* ok... lets ignore it */
	continue;
/* 	puts( "The pid or process group does not exist.  Note that an existing process might be a zombie, a process which already\n" */
/* 	      "committed termination, but has not yet been wait()ed for.\n"); */
	break;
      default:
	printf("Unexpected error returned by kill: %d\n" , errno );
	exit(2);
      }
    }
    if( verbose ){
      printf("Sending SIGUSR1 to automount PID %d\n" , pid );
    }
  }
  fclose( mountsFile );
  return numSignalsSend;
}
static void version(){
  printf("umounter 1.00 by marcos*AT*unitron.com.br\n");
}

static void gnuSplash(){
  printf("This is free software.  You may redistribute copies of it under the terms of\n"
	 "the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.\n"
	 "There is NO WARRANTY, to the extent permitted by law.");
}

static void usage(){
  version();  
  printf("Usage: umounter [OPTION]\n");
  printf("Sends USRSIG1 signal to all instances of automount.\nAutomount is suposed to umount ALL automounted filesystems after receiving such a signal.\nUmounter must be suid root and be in a non nosuid partition to be used by non-root users.\n");
  printf("Options:\n\t--version\tdisplay version\n\t--help\t\tthis screen\n\t--verbose\tverbose mode\n");
           
  exit(0);
}

int main( int argc , char **argv ){
  if( argc > 1 ){
    char *parameter=argv[1];
    if( !strcmp( parameter  , "--verbose" )){
      verbose=true;
    }else if( !strcmp( parameter  , "--help" )) {
      usage();
    }else if( !strcmp( parameter  , "--version" )) {
      version();
      gnuSplash();
      exit(0);
    }
  }

  if( !sendSignalToAllAutoMounts( SIGUSR1 ) ){
    fprintf( stderr , "Warning: no runnung instance of automount found\n");
  }
  return 0;
}
  

--------------010402060101000902040207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------010402060101000902040207--

